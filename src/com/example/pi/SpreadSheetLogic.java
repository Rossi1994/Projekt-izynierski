package com.example.pi;

import java.util.ArrayList;

import com.google.gwt.user.client.ui.ClickListener;
import com.vaadin.client.widgets.Grid;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Grid.Column;
import com.vaadin.ui.Grid.HeaderCell;
import com.vaadin.ui.Grid.HeaderRow;


public class SpreadSheetLogic extends SpreadSheet {

	SpreadSheetLogic()
	{
		
		mainHeaderRow = spreadSheet.prependHeaderRow();

		
		spreadSheet.setColumnReorderingAllowed(true);
		
		spreadSheet.addColumn("Przedmiot", String.class);
		spreadSheet.addColumn(propertyId++);
		spreadSheet.addColumn(propertyId++);
		spreadSheet.getColumn(propertyId-2).setHeaderCaption("Cecha1");
		spreadSheet.getColumn(propertyId-1).setHeaderCaption("Cecha2");
		
		for(int i = 0; i< 10; i++){
			spreadSheet.addRow(null, null, null);
		}
		
		properties = new ArrayList<>();
		properties.add(mainHeaderRow.getCell(propertyId-2));
		properties.add(mainHeaderRow.getCell(propertyId-1));
		HeaderCell hed = mainHeaderRow.getCell("Przedmiot");
		
		 mainHeaderCell = mainHeaderRow.join(properties.get(0), properties.get(1));
		
		hed.setText("Przedmioty");
		mainHeaderCell.setText("Osoba1");
		addPerson();
		addProperty();
		
		}
	
	void hidePerson()
	{
		
		
		
	}
	
	void addProperty()
	{
		//for(int i=1; i<=propertyId/2;i++)
	//	{
		//	spreadSheet.addCol
	//	}
		
		
		
		addButton2.addClickListener(new Button.ClickListener() {
		    public void buttonClick(ClickEvent event) {
		    	
		    	spreadSheet.addColumn(2313131);
		    	properties.add(mainHeaderRow.getCell(2313131));
		    	mainHeaderCell= mainHeaderRow.join(mainHeaderCell, properties.get(2));
		    }});
	}
	
	void addPerson()
	{
		
			addButton.addClickListener(new Button.ClickListener() {
			    public void buttonClick(ClickEvent event) {
			    	spreadSheet.addColumn(propertyId++);
					spreadSheet.addColumn(propertyId++);
					spreadSheet.getColumn(propertyId-2).setHeaderCaption("Cecha1");
					spreadSheet.getColumn(propertyId-1).setHeaderCaption("Cecha2");
					HeaderCell x = mainHeaderRow.join(propertyId-2, propertyId-1);
			    	x.setText("Osoba" + (propertyId/2));
			    }});
		}
	
	
	
	private HeaderCell mainHeaderCell;
	
	private HeaderRow mainHeaderRow;
	private ArrayList<HeaderCell> properties;
	private static int propertyId;
	
	static int idd;
	}
