<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
    <html>
        <head>
            <title>Perfume Store</title>
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
            <style>
				XML {
					display:none;
				}
				body {
					font-family: Arial, Helvetica, sans-serif;
					background-color: #FFFFFF;
					margin: 5px;
					text-align: left;
					color: #523819;
				}
				h2 {
					font-size: 140%;
					color: #0D3427;
					margin-top: 10px;
				}
				p {
					font-size: 80%;
					color: #523819;
				}
				table {
					background-color: #DACFE5;
					border-color: #000000;
					border-width: thin;
					border-collapse: collapse;
					width: 75%;
				}
				th {
					border-color: #000000;
					font-size: 120%;
					color: #0D3427;
				}
				td {
					border-color: #000000;
					font-size: 100%;
					color: #523819;
					padding: 5px;
				}
				img {
					float: left;
					margin-left: 10px;
					margin-right: 10px;
					border: 0px;
				}
				.indent {
					margin-left: 78px;
				}
			</style>
			<script>
				<![CDATA[
					var gPerfumeCount = 0;
															// returns a number that represents the sum of all the selected menu
															// item prices.
					function calculateBill(idPerfumeTable) {
						var fBillTotal = 0.0;
						var i=0;
															// find the table tag
						var oTable = document.getElementById(idPerfumeTable);
															// go through the table and add up the prices of all
															// the selected items. The code takes advantage of the 
															// fact that each checkbox has a corresponding row in
															// the table, and the only INPUT tags are the checkboxes.
						var aCBTags = oTable.getElementsByTagName('INPUT');
						for (i=0; i < aCBTags.length; i++) {
															// is this menu item selected? it is if the checkbox is checked
							if (aCBTags[i].checked) {
															// get the checkbox' parent table row
								var oTR = getParentTag(aCBTags[i],'TR');
		
															// retrieve the price from the price column, which is the third column in the table
								var oTDPrice = oTR.getElementsByTagName('TD')[2];
															// the first child text node of the column contains the price
								fBillTotal += parseFloat(oTDPrice.firstChild.data);
							};
						};
															// return the price as a decimal number with 2 decimal places
						return Math.round(fBillTotal*100.0)/100.0;
					};
															// This function either turns on or off the row highlighting for vegetarian
															// items (depending on the value of bShowVeg)
					function highlightSale(idTable, bShowSale) {
															// if bShowVeg is true, then we're highlighting vegetarian
															//	meals, otherwise we're unhighlighting them.
						var i=0;
						var oTable = document.getElementById(idTable);
						var oTBODY = oTable.getElementsByTagName('TBODY')[0];
						var aTRs = oTBODY.getElementsByTagName('TR');
																// walk through each of the table rows and see if it has a 
																// "vegetarian" attribute on it.
						for (i=0; i < aTRs.length; i++) {
							if (aTRs[i].getAttribute('sale') && aTRs[i].getAttribute('sale') == "true") {
								if (bShowSale){
									aTRs[i].style.backgroundColor = "lightBlue";
								} else {
									aTRs[i].style.backgroundColor = "";
								};
							};
						};
					};
																// Utility function for getting the parent tag of a given tag
																// but only of a certain type (i.e. a TR, a TABLE, etc.)
					function getParentTag(oNode, sParentType) {
						var oParent = oNode.parentNode;
						while (oParent) {
							if (oParent.nodeName == sParentType)
								return oParent;
							oParent = oParent.parentNode;
						};
						return oParent;
					};
			]]>
			</script>
			<script>
			<![CDATA[	
			        window.addEventListener("load", function() {
			            document.forms[0].txtBillAmt.value = calculateBill('perfumeTable');
			            document.querySelector("#calcBill").addEventListener("click", function() {
			                document.forms[0].txtBillAmt.value = calculateBill('perfumeTable');
			            });
			            document.querySelector("#showSale").addEventListener("click", function() {
			                highlightSale('perfumeTable', this.checked);
			            });
			        });
			]]>
			</script>
        </head>
            <body>
                <h2>Best Gift Perfume Store</h2>
                <table id="perfumeTable" border="1" class="indent">
                    <thead>
                        <tr>
                            <th colspan="3">Perfume Store Items</th>
                        </tr>
                        <tr>
                            <th>Select</th>
                            <th>Item</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="/perfume_catalog/section">
                            <tr>
                                <td colspan="3">
                                    <xsl:value-of select="@name" />
                                </td>
                            </tr>
                            <xsl:for-each select="perfume">
                                <tr>
                                    <xsl:attribute name="sale">
                                        <xsl:value-of select="boolean(@sale)" />
                                    </xsl:attribute>
                                    <td align="center">
                                        <input name="item0" type="checkbox" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="item" />
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="price" />
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                    </tbody>
                </table>
                <form class="indent">
                    <p>
                        <input type="button" name="btnCalcBill" value="Calculate Bill" id="calcBill" />
                Total: €
                <input type="text" name="txtBillAmt" /><input type="checkbox" name="cbOpts" value="isSale" id="showSale" /><label for="showSale">Highlight Perfumes on sale</label></p>
                </form>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
