<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="clientID" select="'c3'"/>

    <xsl:template match="/">
        <recipeBoxes>
            <xsl:apply-templates select="recipeBoxes/recipes/recipe[not(allergens-ref/allergen-ref/@idref = /recipeBoxes/customers/customer[@id = $clientID]/allergens-ref/allergen-ref/@idref)]">
                <xsl:sort select="price" data-type="number"/>
                <xsl:sort select="name"/>
            </xsl:apply-templates>
        </recipeBoxes>
    </xsl:template>

    <xsl:template match="recipe">
        <recipe>
            <id><xsl:value-of select="@id"/></id>
            <name><xsl:value-of select="name"/></name>
            <description><xsl:value-of select="description"/></description>
            <imageLink><xsl:value-of select="imageLink"/></imageLink>
            <category>
                <name><xsl:value-of select="/recipeBoxes/categories/category[@id = current()/category-ref/@idref]"/></name>
            </category>
            <price><xsl:value-of select="price"/></price>
            <ingredients>
                <xsl:for-each select="ingredients/ingredient">
                    <ingredient>
                        <aliment>
                            <name><xsl:value-of select="/recipeBoxes/foods/aliment[@id = current()/aliment-ref/@idref]/name"/></name>
                        </aliment>
                        <quantity>
                            <value><xsl:value-of select="quantity/value"/></value>
                            <unit><xsl:value-of select="quantity/unit"/></unit>
                        </quantity>
                    </ingredient>
                </xsl:for-each>
            </ingredients>
            <difficulty><xsl:value-of select="difficulty"/></difficulty>
            <serves><xsl:value-of select="serves"/></serves>
            <time>
                <prep><xsl:value-of select="time/prep"/></prep>
                <cook><xsl:value-of select="time/cook"/></cook>
            </time>
            <aspects-ref>
                <xsl:for-each select="aspects-ref/aspect-ref">
                    <aspect>
                        <name><xsl:value-of select="/recipeBoxes/aspects/aspect[@id = current()/@idref]"/></name>
                    </aspect>
                </xsl:for-each>
            </aspects-ref>
            <directions>
                <xsl:for-each select="directions/direction">
                    <direction><xsl:value-of select="."/></direction>
                </xsl:for-each>
            </directions>
            <nutritionalValue>
                <energieKJ><xsl:value-of select="nutritionalValue/energieKJ"/></energieKJ>
                <energieKcal><xsl:value-of select="nutritionalValue/energieKcal"/></energieKcal>
                <fat><xsl:value-of select="nutritionalValue/fat"/></fat>
                <acideAcidulees><xsl:value-of select="nutritionalValue/acideAcidulees"/></acideAcidulees>
                <glucides><xsl:value-of select="nutritionalValue/glucides"/></glucides>
                <sucres><xsl:value-of select="nutritionalValue/sucres"/></sucres>
                <proteine><xsl:value-of select="nutritionalValue/proteine"/></proteine>
                <sel><xsl:value-of select="nutritionalValue/sel"/></sel>
            </nutritionalValue>
            <allergens>
                <xsl:for-each select="allergens-ref/allergen-ref">
                    <allergen>
                        <value><xsl:value-of select="/recipeBoxes/allergens/allergen[@id = current()/@idref]/value"/></value>
                    </allergen>
                </xsl:for-each>
            </allergens>
        </recipe>
    </xsl:template>
</xsl:stylesheet>