/*
 * ome.xml.r2003fc.ome.PlateRefNode
 *
 *-----------------------------------------------------------------------------
 *
 *  Copyright (C) 2007 Open Microscopy Environment
 *      Massachusetts Institute of Technology,
 *      National Institutes of Health,
 *      University of Dundee,
 *      University of Wisconsin-Madison
 *
 *
 *
 *    This library is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation; either
 *    version 2.1 of the License, or (at your option) any later version.
 *
 *    This library is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public
 *    License along with this library; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *-----------------------------------------------------------------------------
 */

/*-----------------------------------------------------------------------------
 *
 * THIS IS AUTOMATICALLY GENERATED CODE.  DO NOT MODIFY.
 * Created by curtis via xsd-fu on 2008-05-31 10:06:36-0500
 *
 *-----------------------------------------------------------------------------
 */

package ome.xml.r2003fc.ome;

import ome.xml.DOMUtil;
import ome.xml.OMEXMLNode;

import java.util.Vector;
import java.util.List;

import org.w3c.dom.Element;

public class PlateRefNode extends ReferenceNode
{
	// -- Constructors --

	/** Constructs a PlateRef node with an associated DOM element. */
	public PlateRefNode(Element element)
	{
		super(element);
	}

	/**
	 * Constructs a PlateRef node with an associated DOM element beneath
	 * a given parent.
	 */
	public PlateRefNode(OMEXMLNode parent)
	{
		this(parent, true);
	}

	/**
	 * Constructs a PlateRef node with an associated DOM element beneath
	 * a given parent.
	 */
	public PlateRefNode(OMEXMLNode parent, boolean attach)
	{
		super(DOMUtil.createChild(parent.getDOMElement(),
		                          "PlateRef", attach));
	}

	/** 
	 * Returns the <code>PlateNode</code> which this reference
	 * links to.
	 */
	public PlateNode getPlate()
	{
		return (PlateNode)
			getAttrReferencedNode("Plate", "ID");
	}

	/**
	 * Sets the active reference node on this node.
	 * @param node The <code>PlateNode</code> to set as a
	 * reference.
	 */
	public void setPlateNode(PlateNode node)
	{
		setNodeID(node.getNodeID());
	}

	// -- PlateRef API methods --
              
	// Attribute
	public Integer getSample()
	{
		return getIntegerAttribute("Sample");
	}

	public void setSample(Integer sample)
	{
		setAttribute("Sample", sample);
	}
                                            
	// Attribute
	public String getWell()
	{
		return getStringAttribute("Well");
	}

	public void setWell(String well)
	{
		setAttribute("Well", well);
	}
                                                                    
	// *** WARNING *** Unhandled or skipped property ID
      
	// -- OMEXMLNode API methods --

	public boolean hasID()
	{
		return true;
	}
}

