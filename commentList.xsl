<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="keyRecipe" match="recipe" use="@id"/>
    <xsl:key name="keyCustomer" match="customer" use="@id"/>

    <xsl:template match="/">
        <html>
            <head>
                <style>
                    table, th, td {
                    border: 1px solid;
                    }
                    table{
                    width : 100%;
                    }
                    .header{
                    background-color: green;
                    }

                </style>
            </head>
            <body>
                <h2>COMMENTS</h2>
                <table>
                    <tr>
                        <th class="header">RECIPE</th>
                        <th class="header">CUSTOMER</th>
                        <th class="header">SCORE</th>
                        <th class="header">DESCRIPTION</th>
                    </tr>
                    <xsl:for-each select="recipeBoxes/comments/comment">
                        <tr>
                            <th><xsl:value-of select="key('keyRecipe', recipe-ref/@idref)/name"/> </th>
                            <th><xsl:value-of select="key('keyCustomer', customer-ref/@idref)/firstname"/> <xsl:value-of select="key('keyCustomer', customer-ref/@idref)/lastname"/></th>
                            <th><xsl:value-of select="note"/></th>
                            <th><xsl:value-of select="description"/></th>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>