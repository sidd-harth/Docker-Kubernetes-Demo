package com.example.employee.controller;

import com.example.employee.model.Employee;
import com.example.employee.repository.EmployeeRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.validation.Valid;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api")
public class EmployeeController {

	@Autowired
	EmployeeRepository employeeRepository;

	@GetMapping("/info")
	public String info() {
		return "Employees Service Deployed!!!!!";
	}

	@GetMapping("/pod")
    public String whereami() {
        return String.format("Pod -  %s", System.getenv().getOrDefault("HOSTNAME", "localhost"));
    }

	@GetMapping("/employees")
	public List<Employee> getAllemployees() {
		return employeeRepository.findAll();
	}

	private ObjectMapper mapper = new ObjectMapper();

	@GetMapping("/employees/{id}")
	@HystrixCommand(fallbackMethod = "getDataFromFallBack")
	public String getemployeeById(@PathVariable(value = "id") Long id) throws JsonProcessingException {
		Employee employee = employeeRepository.findOne(id);

		System.out.println(employee);
		System.out.println(mapper.writerWithDefaultPrettyPrinter().writeValueAsString(employee));

		String mysqlResponse = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(employee);

		String browserService = "http://browser-service-nodejs-mongdb.7e14.starter-us-west-2.openshiftapps.com/specific/"+ id;
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> browserResponse = null;
		try {
			browserResponse = restTemplate.exchange(browserService, HttpMethod.GET, getHeaders(), String.class);
		} catch (Exception ex) {
			System.out.println(ex);
		}
		System.out.println(browserResponse.getBody());

		return ("[" + mysqlResponse + "," + browserResponse.getBody() + "]");

	}

	public String getDataFromFallBack(@PathVariable Long id) throws JsonProcessingException {

		return ("{\"id\":" + id + ", \"fallback\":\"DATA\"}");
	}

	private static HttpEntity<?> getHeaders() throws IOException {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
		return new HttpEntity<>(headers);
	}

	@PostMapping("/employees")
	public Employee createEmployee(@Valid @RequestBody Employee employee) {
		return employeeRepository.save(employee);
	}

	@PutMapping("/employees/{id}")
	public ResponseEntity<Employee> updateemployee(@PathVariable(value = "id") Long employeeId,
			@Valid @RequestBody Employee employeeDetails) {
		Employee employee = employeeRepository.findOne(employeeId);
		if (employee == null) {
			return ResponseEntity.notFound().build();
		}
		employee.setName(employeeDetails.getName());
		employee.setCity(employeeDetails.getCity());

		Employee updatedemployee = employeeRepository.save(employee);
		return ResponseEntity.ok(updatedemployee);
	}

	@DeleteMapping("/employees/{id}")
	public ResponseEntity<Employee> deleteemployee(@PathVariable(value = "id") Long employeeId) {
		Employee employee = employeeRepository.findOne(employeeId);
		if (employee == null) {
			return ResponseEntity.notFound().build();
		}

		employeeRepository.delete(employee);
		return ResponseEntity.ok().build();
	}

}
