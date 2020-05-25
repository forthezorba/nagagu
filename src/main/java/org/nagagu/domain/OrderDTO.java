package org.nagagu.domain;

import java.util.ArrayList;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderDTO{
	private int cntById;
	private  ArrayList<Map<String,Object>> list;
}
