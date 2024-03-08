<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="keyAliment" match="aliment" use="@id"/>

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
                <h2>RECIPES</h2>
                <table>
                    <tr>
                        <th class="header">RECIPE</th>
                        <th class="header">DESCRIPTION</th>
                        <th class="header">INGREDIENTS</th>
                    </tr>
                    <xsl:for-each select="recipeBoxes/recipes/recipe">
                        <tr>
                            <th><xsl:value-of select="name"/></th>
                            <th><xsl:value-of select="description"/></th>
                            <th>
                                <xsl:for-each select="ingredients/ingredient">
                                    <p>
                                        <xsl:value-of select="key('keyAliment', aliment-ref/@idref)/name"/> : <xsl:value-of select="quantity"/>
                                    </p>
                                </xsl:for-each>
                            </th>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>