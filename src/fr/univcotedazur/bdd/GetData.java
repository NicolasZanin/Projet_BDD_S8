package fr.univcotedazur.bdd;

import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.XPath;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetData {
    private GetData() {
        throw new IllegalArgumentException("Utility class\n");
    }

    public static int getNumberOfCustomer(Element root) {
        XPath xpath = root.createXPath("//customer");
        return xpath.selectNodes(root).size();
    }

    public static Map<String, Integer> getNumberOfIngredientsDependingRecipe(Element root) {
        List<Node> recipes = root.selectNodes("//recipe");
        Map<String, Integer> map = new HashMap<>();

        for (Node recipe : recipes) {
            String nameRecipe = recipe.selectSingleNode("name").getText();
            Integer numberIngredient = recipe.selectNodes("ingredients/ingredient").size();
            map.put(nameRecipe, numberIngredient);
        }

        return map;
    }

    public static Map<String, Integer> getNumberOfCustomerCommentsDependingRecipe(Element root) {
        List<Node> comments = root.selectNodes("//comment");
        Map<String, Integer> map = new HashMap<>();

        for (Node comment : comments) {
            Element recipe = (Element) comment.selectSingleNode("recipe-ref");
            String idRef = recipe.attributeValue("idref");

            if (map.containsKey(idRef))
                map.put(idRef, 1 + map.get(idRef));
            else
                map.put(idRef, 1);
        }

        Map<String, Integer> map2 = new HashMap<>();
        List<Node> recipes = root.selectNodes("//recipe");

        for (Node recipe : recipes) {
            String nameRecipe = recipe.selectSingleNode("name").getText();
            String id = ((Element) recipe).attributeValue("id");
            Integer numberOfComments = map.get(id);
            map2.put(nameRecipe, numberOfComments);
        }

        return map2;
    }
}
