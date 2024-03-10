package fr.univcotedazur.bdd;

import java.util.Map;

public class Output {
    private Output() {
        throw new IllegalArgumentException("Utility class\n");
    }

    public static void printNumberCustomer(Integer numberOfCustomer) {
        System.out.println("Nombre customer dans le xml : " + numberOfCustomer);
    }

    public static void printMap(String beginText, Map<String, Integer> ingredientsRecipes) {
        StringBuilder builder = new StringBuilder(beginText);

        for (Map.Entry<String,Integer> ingredientRecipe : ingredientsRecipes.entrySet()) {
            builder.append(ingredientRecipe.getKey()).append(" : ").append(ingredientRecipe.getValue()).append(" \n");
        }

        System.out.println(builder);
    }
}
