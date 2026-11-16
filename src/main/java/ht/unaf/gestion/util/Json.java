package ht.unaf.gestion.util;

import java.util.Collection;
import java.util.stream.Collectors;

/** Mini-sérialisation JSON pour alimenter les graphiques (Chart.js) depuis les JSP. */
public final class Json {
    private Json() {}

    public static String chaines(Collection<?> valeurs) {
        return valeurs.stream().map(v -> chaine(String.valueOf(v))).collect(Collectors.joining(",", "[", "]"));
    }

    public static String nombres(Collection<? extends Number> valeurs) {
        return valeurs.stream().map(String::valueOf).collect(Collectors.joining(",", "[", "]"));
    }

    public static String chaine(String s) {
        StringBuilder b = new StringBuilder("\"");
        for (char ch : s.toCharArray()) {
            switch (ch) {
                case '"' -> b.append("\\\"");
                case '\\' -> b.append("\\\\");
                case '<' -> b.append("\\u003c");
                case '>' -> b.append("\\u003e");
                case '&' -> b.append("\\u0026");
                case '\n' -> b.append("\\n");
                case '\r' -> b.append("\\r");
                default -> b.append(ch < 0x20 ? String.format("\\u%04x", (int) ch) : String.valueOf(ch));
            }
        }
        return b.append('"').toString();
    }
}
