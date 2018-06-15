with packageCategoria;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
--
-- Esto es la carta, es decir, el array que indexado por categorias y que cada
-- categoría (tcategoría) contiene los tries
--
package packageCarta is

   type carta is limited private;
   subtype codi is Character range '@' .. 'Z';
   -- Damos un margen de números naturales suficiente para poder abarcar
   -- todas las claves del subtipo codis
   type index is new Natural range 1..50;
   type tcodi is array(index) of codi;

   type tcategoria is (Entrant, Primer, Segon, Postres, Begudes);
   type tqualificacio is (Bo, Mitja, Dolent);

   mal_uso: exception;
   no_existe: exception;
   ya_existe: exception;
   espacio_desbordado: exception;

   procedure carta_buida (c: out carta);
   -- Introduce un plato en la carta
   procedure posar_element (c: in out carta; cat : in tcategoria; k: in tcodi; nom: in Unbounded_String);
   -- Imprime todos los elementos de una categoria ordenados por codigo
   procedure imprimir_elements(c : in carta; cat : in tcategoria);
   -- Elimina un plato de la carta
   procedure eliminar_element (c: in out carta; cat : in tcategoria; k: in tcodi);
   -- Introduce un comentario
   procedure posar_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio; comentari : in Unbounded_String);
   -- Devuelve un comentario
   function consulta_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Unbounded_String;
   -- Existe un comentario
   function existeix_comentari(c : in carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Boolean;
   -- Elimina un comentario
   procedure eliminar_comentari (c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio);

   -- function existe (s: in carta; x: in elem) return boolean;
   -- function esta_buida(s: in carta) return boolean;

private
   -- instanciamos nuestro tcategoria para que sepa que indices y valores debe tomar
   package cat_trie is new packageCategoria (key_codi => codi,
                                             key_index => index,
                                             key => tcodi,
                                             tqualificacio => tqualificacio);
   use cat_trie;

   -- Carta es un array indexado por las 5 categorias definidas al inicio del ads
   -- y de las cuales cada una colgará un trie de tipo tcategoria
   type t_carta is array(tcategoria) of cat_trie.trie;
   type carta is record
      c: t_carta;
   end record;
end packageCarta;
