<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:key name="keyDeliveryMan" match="recipeBoxes/deliverymen/deliveryman" use="@id"/>
<xsl:key name="keyCustomer" match="recipeBoxes/customers/customer" use="@id"/>
<xsl:key name="keyMenubox" match="recipeBoxes/menuboxes/menubox" use="@id"/>
<xsl:template match="/">
    <html>
        <head>
            <style>
                body {
                    text-align: center;
                }
                table, th, td {
                    border: 1px solid;
                    text-align: center;
                }
                table {
                    width : 100%;
                }
                th {
                    background-color: #aaeeaa;
                }
            </style>
        </head>
        <body>
            <h2>STAT DELIVERY</h2>
            <table>
                <tr>
                    <th>DelivryMan</th>
                    <th>Customer</th>
                    <th>Nombre de menu livré</th>
                </tr>
                <xsl:for-each select="recipeBoxes/orders/order">
                    <xsl:sort select="key('keyDeliveryMan', deliveryman-ref/@idref)/firstname"/>
                    <tr>
                        <td><xsl:value-of select="key('keyDeliveryMan', deliveryman-ref/@idref)/firstname"/><xsl:text> </xsl:text><xsl:value-of select="key('keyDeliveryMan', deliveryman-ref/@idref)/lastname"/></td>
                        <td><xsl:value-of select="key('keyCustomer', customer-ref/@idref)/firstname"/><xsl:text> </xsl:text><xsl:value-of select="key('keyCustomer', customer-ref/@idref)/lastname"/></td>
                        <td><xsl:value-of select="count(menus/menu) + count(key('keyMenubox', menuboxes-ref/menubox-ref/@idref))"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>