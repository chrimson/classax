package classAx.model;

import java.io.*;
import java.util.*;

import javax.xml.bind.annotation.*;

@XmlRootElement(name = "Car")
public class Car implements Serializable {
    private static final long serialVersionUID = 1L; 

	private List<Object> specs;
	
	public Car(List<Object> specs) {
		this.specs = specs;
	}
	
    @XmlElement
	public Object getSpecs() {
		return specs;
	}
}