generic
   type elem is private;
package dcola is
   type cola is limited private;

   mal_uso: exception;
   espacio_desbordado: exception;

   procedure cvacia (c: out cola);
   procedure poner (c: in out cola; x: in elem);
   procedure borrar_primero(c: in out cola);
   function coger_primero(c: in cola) return elem;
   function esta_vacia(c: in cola) return boolean;
   function es_ultimo_elemento(c:in cola) return boolean;
   function num_elem(c: in cola) return integer;
private
   type nodo;
   type pnodo is access nodo;
   type nodo is record
      x: elem;
      sig: pnodo;
   end record;

   type cola is record
      p, q: pnodo;
   end record;
end dcola;
