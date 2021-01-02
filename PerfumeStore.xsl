<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
    <html>
        <head>
            <title>Perfume Store</title>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <link rel="stylesheet" href="css/PerfumeStore.css" />
			<script type="text/javascript" src="js/PerfumeStore.js">#</script> 
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
