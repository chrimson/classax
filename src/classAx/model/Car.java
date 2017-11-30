package classAx.model;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement; 

@XmlRootElement(name = "Car")
public class Car implements Serializable {
    private static final long serialVersionUID = 1L; 

	private int year;
	private String make;
	
	public Car(int year, String make) {
		this.year = year;
		this.make = make;
	}
	
    @XmlElement
	public int getYear() {
		return year;
	}

    @XmlElement 
	public String getMake() {
		return make;
	}
}
