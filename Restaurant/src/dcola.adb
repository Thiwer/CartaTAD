with Ada.Text_IO, Ada.Strings.Unbounded;
use Ada.Text_IO, Ada.Strings.Unbounded;
package body dcola is

   procedure cvacia (c: out cola) is
      p: pnodo renames c.p;
      q: pnodo renames c.q;
   begin
      p:= null; q:= null;
   end cvacia;

   function esta_vacia (c: in cola) return boolean is
      q: pnodo renames c.q;
   begin
      return q = null;
   end esta_vacia;

   function coger_primero(c: in cola) return elem is
      q: pnodo renames c.q;
   begin
      return q.x;
   exception
         when Constraint_Error => raise mal_uso;
   end coger_primero;

   procedure poner (c: in out cola; x: in elem) is
      p: pnodo renames c.p;
      q: pnodo renames c.q;
      r: pnodo;
   begin
      r:= new nodo;
      r.all := (x,null);
      -- Si la cola está vacía
      if p = null then
         p:= r; q:= r;
      else
         p.sig := r; p:= r;
      end if;

   exception
      when storage_error => raise espacio_desbordado;
         when Constraint_Error => raise mal_uso;
   end poner;

   procedure borrar_primero (c:in out cola) is
      p: pnodo renames c.p;
      q: pnodo renames c.q;
   begin
      q := q.sig;

      if q = null then
         p:= null;
      end if;

   exception
      when Constraint_Error => raise mal_uso;
   end borrar_primero;

   function es_ultimo_elemento(c: in cola) return boolean is
      p: pnodo renames c.p;
      q: pnodo renames c.q;
   begin
      return not esta_vacia(c) and p = q;
   end es_ultimo_elemento;

   function num_elem(c: in cola) return integer is
      p: pnodo renames c.p;
      q2: pnodo renames c.q;
      q: pnodo;
      i: Integer:= 0;
   begin
      q := q2;
      if q = null then return 0; end if;
      if q = p then return 1; end if;
      while q /= null and i < 10 loop
         q := q.sig;
         i:= i+1;
      end loop;

      return i;
   end num_elem;


end dcola;
