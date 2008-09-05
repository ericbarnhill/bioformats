/*
 * ome.xml.r2003fc.ome.DichroicNode
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

public class DichroicNode extends FilterSpecNode
{
	// -- Constructors --

	/** Constructs a Dichroic node with an associated DOM element. */
	public DichroicNode(Element element)
	{
		super(element);
	}

	/**
	 * Constructs a Dichroic node with an associated DOM element beneath
	 * a given parent.
	 */
	public DichroicNode(OMEXMLNode parent)
	{
		this(parent, true);
	}

	/**
	 * Constructs a Dichroic node with an associated DOM element beneath
	 * a given parent.
	 */
	public DichroicNode(OMEXMLNode parent, boolean attach)
	{
		super(DOMUtil.createChild(parent.getDOMElement(),
		                          "Dichroic", attach));
	}

	// -- Dichroic API methods --

	// -- OMEXMLNode API methods --

	public boolean hasID()
	{
		return false;
	}
}

