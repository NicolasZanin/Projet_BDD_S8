package fr.univcotedazur.bdd;

import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.XPath;

import java.util.ArrayList;
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

    public static Map<String, Integer> getNumberOfCustomerCommentsDependingRecipeId(Element root) {
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

        return map;
    }

    public static Map<String, Integer> getNumberOfCustomerCommentsDependingRecipe(Element root) {
        Map<String, Integer> map = getNumberOfCustomerCommentsDependingRecipeId(root);
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

    public static double getAverageCustomerDependingRecipe(Element root) {
        Map<String, Integer> map = getNumberOfCustomerCommentsDependingRecipeId(root);

        if (!map.isEmpty())
            return (double) map.values().stream().reduce(Integer::sum).get() / map.size();

        return 0;
    }

    public static double getAverageScoreComment(Element root) {
        List<Node> grades = root.selectNodes("//comments/comment/note");
        double average = 0.0;

        for (Node grade : grades) {
            average += Double.parseDouble(grade.getText());
        }

        if (grades.isEmpty())
            return 0;

        return average / grades.size();
    }

    public static List<String> getCustomers(Element root) {
        List<Node> customers = root.selectNodes("//customers/customer");
        List<String> finalListCustomer = new ArrayList<>();

        for (Node customer : customers) {
            String firstname = customer.selectSingleNode("firstname").getText();
            String lastname = customer.selectSingleNode("lastname").getText();
            String mail = customer.selectSingleNode("mail").getText();

            finalListCustomer.add(String.format("Name : %s%nLastname : %s%nMail : %s%n", firstname, lastname, mail));
        }

        return finalListCustomer;
    }

    public static List<String> getAliments(Element root) {
        return root.selectNodes("//foods/aliment/name").stream().map(Node::getText).toList();
    }
}
