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
		HeaderRow1 = spreadSheet.prependHeaderRow();
		mainHeaderRow = spreadSheet.prependHeaderRow();

		
		spreadSheet.addColumn("Przedmiot", String.class);
		spreadSheet.addColumn("Cecha1", String.class);
		spreadSheet.addColumn("Cecha2", String.class);
		
		for(int i = 0; i< 10; i++){
			spreadSheet.addRow(null, null, null);
		}
		
		properties = new ArrayList<>();
		properties.add(mainHeaderRow.getCell("Cecha1"));
		properties.add(mainHeaderRow.getCell("Cecha2"));
		HeaderCell hed = mainHeaderRow.getCell("Przedmiot");
		
		HeaderCell mainHeaderCell = mainHeaderRow.join(properties.get(0), properties.get(1));
		
		hed.setText("Przedmioty");
		mainHeaderCell.setText("Osoba");
		addPerson();
	}
	
	
	void addProperty()
	{
		
	}
	
	void addPerson()
	{
		
			addButton.addClickListener(new Button.ClickListener() {
			    public void buttonClick(ClickEvent event) {
			    	spreadSheet.addColumn("Cecha11", String.class);
					spreadSheet.addColumn("Cecha22", String.class);
					Column c = spreadSheet.getColumn("Cecha11");
					//c.setHeaderCaption("Cecha1");
					c.setHeaderCaption(null);
			    	HeaderCell x = mainHeaderRow.join("Cecha11", "Cecha22");
			    	x.setText("Osobax");
			    }});
			
	}
	
	
	private HeaderRow mainHeaderRow;
	private HeaderRow HeaderRow1;
	private ArrayList<HeaderCell> properties;
	
}
