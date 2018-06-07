--
-- Esto es la carta, es decir, el array que indexado por categorias y que cada 
-- categoría (tcategoría) contiene los tries
-- 
package carta is

   type key_categoria is (entrat, primer, segon, postres, begudes); -- tipo discreto componentes
   package dc is new dcola(elem => Unbounded_String);
   use dc;
   package categoria is new tcategoria(elem => Unbounded_String, ddcola =>dc);
   use categoria;

   espacio_desbordado: exception;

   procedure carta_buida (s: out carta);
   -- Introduce un plato en la carta
   procedure posar_element (c: in out carta; cat : in tcategoria; k: in tcodi; nom: in Unbounded_String);
   -- Imprime todos los elementos de una categoria ordenados por codigo
   procedure imprimir_elements(c : in carta; cat : in tcategoria);
   -- Elimina un plato de la carta
   procedure eliminar_element (c: in out carta; cat : in tcategoria; k: in tcodi);
   -- Introduce un comentario
   procedure posar_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio; comentari : in Unbounded_String);
   -- Devuelve un comentario
   function consulta_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Unbounded_String);
   -- Existe un comentario
   function existeix_comentari(c : in carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Boolean;
   -- Elimina un comentario
   procedure eliminar_comentari (c : in out carta; cat : in tcategoria; k : in tcodi; cal : in tqualificacio) ;

   -- function existe (s: in carta; x: in elem) return boolean;
   -- function esta_buida(s: in carta) return boolean;



private
   
   type t_caregorias is array(key_categoria) of categoria;
   type carta is
      record
         raiz: t_caregorias;
      end record;
end carta;
