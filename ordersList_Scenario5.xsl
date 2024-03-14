<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:key name="keyCustomer" match="recipeBoxes/customers/customer" use="@id"/>
    <xsl:key name="keyDeliveryMan" match="recipeBoxes/deliverymen/deliveryman" use="@id"/>
    <xsl:key name="keyAspect" match="recipeBoxes/aspects/aspect" use="@id"/>
    <xsl:key name="keyAliment" match="recipeBoxes/foods/aliment" use="@id"/>
    <xsl:key name="keyAllergene" match="recipeBoxes/allergens/allergen" use="@id"/>
    <xsl:key name="keyCategory" match="recipeBoxes/categories/category" use="@id" />
    <xsl:key name="keyMenubox" match="recipeBoxes/menuboxes/menubox" use="@id" />
    <xsl:template match="/">
{
        "orders" :<xsl:apply-templates select="recipeBoxes/orders"/>
}
    </xsl:template>
    <xsl:template match="orders">
[
            <xsl:apply-templates select="order"/>
]
    </xsl:template>
    <xsl:template match="order">
{
    <xsl:choose>
        <xsl:when test="count(menus) != 0">"menus" : <xsl:apply-templates select="menus"/>,</xsl:when>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="count(menuboxes-ref) != 0">"menuboxes" : <xsl:apply-templates select="menuboxes-ref"/>,</xsl:when>
    </xsl:choose>
    "customer" : <xsl:apply-templates select="customer-ref" />,
    "deliveryman" : <xsl:apply-templates select="deliveryman-ref" />
}<xsl:choose><xsl:when test="position() != last()">,</xsl:when></xsl:choose>
    </xsl:template>
    <xsl:template match="customer-ref">
{
    "firstname": "<xsl:value-of select="key('keyCustomer', @idref)/firstname"/>",
    "lastname": "<xsl:value-of select="key('keyCustomer', @idref)/lastname"/>",
    "mail" : "<xsl:value-of select="key('keyCustomer', @idref)/mail"/>",
    "allergens" : <xsl:apply-templates select="key('keyCustomer', @idref)/allergens-ref"/>
}
    </xsl:template>
    <xsl:template match="deliveryman-ref">
{
    "firstname": "<xsl:value-of select="key('keyDeliveryMan', @idref)/firstname"/>",
    "lastname": "<xsl:value-of select="key('keyDeliveryMan', @idref)/lastname"/>",
    "mail" : "<xsl:value-of select="key('keyDeliveryMan', @idref)/mail"/>",
    "score" : <xsl:value-of select="key('keyDeliveryMan', @idref)/score"/>
}
    </xsl:template>
    <xsl:template match="menus">
[
        <xsl:apply-templates select="menu/recipe-ref[@idref = /recipeBoxes/recipes/recipe/@id]"/>
]
    </xsl:template>
    <xsl:template match="recipe-ref">
{
    "name": "<xsl:value-of select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/name"/>",
    "description": "<xsl:value-of select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/description"/>",
    "imageLink": "<xsl:value-of select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/imageLink"/>",
    "category": "<xsl:value-of select="(/recipeBoxes/categories/category[@id=(/recipeBoxes/recipes/recipe[@id=current()/@idref])/category-ref/@idref])"/>",
    "price": <xsl:value-of select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/price"/>,
    "ingredients": <xsl:apply-templates select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/ingredients"/>,
    "difficulty": "<xsl:value-of select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/difficulty"/>",
    "serves": <xsl:value-of select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/serves"/>,
    "time": <xsl:apply-templates select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/time"/>,
    "aspects" : <xsl:apply-templates select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/aspects-ref"/>,
    "nutritionalValues" : <xsl:apply-templates select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/nutritionalValue"/>,
    "allergens" : <xsl:apply-templates select="(/recipeBoxes/recipes/recipe[@id=current()/@idref])/allergens-ref"/>
}<xsl:choose><xsl:when test="position() != last()">,</xsl:when></xsl:choose>
    </xsl:template>
    <xsl:template match="time">
        {
            "prep" : "<xsl:value-of select="prep"/>",
            "cook" : "<xsl:value-of select="cook"/>"
        }
    </xsl:template>
    <xsl:template match="aspects-ref">
[
        <xsl:apply-templates select="aspect-ref"/>
]
    </xsl:template>
    <xsl:template match="aspect-ref">
{
    "name": "<xsl:value-of select="key('keyAspect', @idref)"/>"
}<xsl:choose><xsl:when test="position() != last()">,</xsl:when></xsl:choose>
    </xsl:template>
    <xsl:template match="nutritionalValue">
{
    "energieKJ": <xsl:value-of select="energieKJ"/>,
    "energieKcal": <xsl:value-of select="energieKcal"/>,
    "fat": <xsl:value-of select="fat"/>,
    "acideAcidulees": <xsl:value-of select="acideAcidulees"/>,
    "glucides": <xsl:value-of select="glucides"/>,
    "sucres": <xsl:value-of select="sucres"/>,
    "proteine": <xsl:value-of select="proteine"/>,
    "sel": <xsl:value-of select="sel"/>
}
    </xsl:template>
    <xsl:template match="allergens-ref">
[
        <xsl:apply-templates select="allergen-ref"/>
]
    </xsl:template>
    <xsl:template match="allergen-ref">
{
    "value" : "<xsl:value-of select="key('keyAllergene', @idref)/value"/>",
    "image" : "<xsl:value-of select="key('keyAllergene', @idref)/imageLink"/>"
}<xsl:choose><xsl:when test="position() != last()">,</xsl:when></xsl:choose>
    </xsl:template>
    <xsl:template match="ingredients">
[
    <xsl:apply-templates select="ingredient"/>
]
    </xsl:template>
    <xsl:template match="ingredient">
{
    "aliment" : <xsl:apply-templates select="aliment-ref"/>,
    "quantity" : <xsl:apply-templates select="quantity"/>
}<xsl:choose><xsl:when test="position() != last()">,</xsl:when></xsl:choose>
    </xsl:template>
    <xsl:template match="aliment-ref">
{
    "name" : "<xsl:value-of select="key('keyAliment', @idref)/name"/>",
    "image" : "<xsl:value-of select="key('keyAliment', @idref)/imageLink"/>"
}
    </xsl:template>
    <xsl:template match="quantity">
{
    "value" : <xsl:value-of select="value"/>,
    "unit" : "<xsl:value-of select="unit"/>"
}
    </xsl:template>
    <xsl:template match="menuboxes-ref">
[
    <xsl:apply-templates select="menubox-ref"/>
]
    </xsl:template>
    <xsl:template match="menubox-ref">
{
    "numberPerson" : <xsl:value-of select="key('keyMenubox', @idref)/numberPerson"/>,
    "numberOfDish" : <xsl:value-of select="key('keyMenubox', @idref)/numberOfDish"/>,
    "recipes" : <xsl:apply-templates select="key('keyMenubox', @idref)/recipesBoxes"/>
}
    </xsl:template>
    <xsl:template match="recipesBoxes">
[
    <xsl:apply-templates select="quantityRecipe"/>
]
    </xsl:template>
    <xsl:template match="quantityRecipe">
{
    "quantity" : <xsl:value-of select="quantity"/>,
    "recipe" : <xsl:apply-templates select="recipe-ref"/>
}<xsl:choose><xsl:when test="position() != last()">,</xsl:when></xsl:choose>
    </xsl:template>
</xsl:stylesheet>