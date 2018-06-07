
package body tqualificacio is

   procedure cvacia(qu: out cola) is
      p: indice renames qu.p;
      q: indice renames qu.q;
      n: natural renames qu.n;
   begin
      p:= 1; q:= 1; n:= 0;
   end cvacia;

   procedure poner(qu: in out cola; x: in elem) is
      a: espacio_memoria renames qu.a;
      p: indice renames qu.p;
      n: natural renames qu.n;
   begin
      if n=tamaño then
         raise espacio_desbordado;
      end if ;
      a(p):= x; p:= p mod max + 1; n:= n+1;
   end poner;

   procedure borrar_primero(qu: in out cola) is
      q: indice renames qu.q;
      n: natural renames qu.n;
   begin
      if n=0 then raise mal_uso; end if ;
      q:= q mod max + 1; n:= n-1;
   end borrar_primero;

   function esta_vacia (qu: in cola) return boolean is
      n: natural renames qu.n;
   begin
      return n=0;
   end esta_vacia;

   function coger_primero(qu: in cola) return elem is
      a: espacio_memoria renames qu.a;
      q: indice renames qu.q;
      n: natural renames qu.n;
   begin
      if n=0 then raise mal_uso; end if ;
      return a(q);
   end coger_primero;


end tqualificacio;
