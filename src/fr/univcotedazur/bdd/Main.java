package fr.univcotedazur.bdd;

import org.dom4j.*;
import org.dom4j.io.SAXReader;

import static fr.univcotedazur.bdd.GetData.*;
import static fr.univcotedazur.bdd.Output.*;

public class Main {
    public static void main(String... args) throws DocumentException {
        SAXReader reader = new SAXReader();
        Document document = reader.read("./doc.xml");
        Element element = document.getRootElement();
        printNumberCustomer(getNumberOfCustomer(element));
        printMap("\nNombre d'ingrédients par recette :\n", getNumberOfIngredientsDependingRecipe(element));
        printMap("Nombre de commentaires par recette :\n", getNumberOfCustomerCommentsDependingRecipe(element));
        printNumberAverage("Nombre moyen de commentaires par recette :\n", getAverageCustomerDependingRecipe(element));
        printNumberAverage("Score moyen des commentaires :\n", getAverageScoreComment(element));
        printList("Les utilisateurs :\n", getCustomers(element));
        printList("Les aliments :\n", getAliments(element));
    }
}
