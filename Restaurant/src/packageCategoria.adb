
package body packageCategoria is
   mk: constant key_codi:= key_codi'first;
   lastc: constant key_codi:= key_codi'last;
   i0: constant key_index := key_index'first;

   procedure tvacio(t: out trie) is
      raiz: pnodo renames t.raiz;
   begin
      -- Como la raiz es el primer nodo, este tiene que ser de tipo
      -- interior de donde empezarán a colgarse los demás interiores.
      -- Por defecto, estos apuntarán a null para indicar que no hay
      -- un puntero válido
      raiz:= new nodo(interior);
      raiz.ti := (others => null);
   end tvacio;

   function esta_vacio(t: in trie) return boolean is
      raiz: pnodo renames t.raiz;
      c: key_codi;
      nd: integer;
   begin
      c:= mk; nd:= 0;
      while c/=lastc loop
         if raiz.ti(c)/= null then nd:= nd+1; end if;
         c:= key_codi'succ(c);
      end loop;
      if raiz.ti(c)/= null then nd:= nd+1; end if;
      return nd=0;
   end esta_vacio;

   function existe(t: in trie; k: in key) return boolean is
      raiz: pnodo renames t.raiz;
      p: pnodo;
      i: key_index;
      c: key_codi;
      indice: Integer;
   begin
      p:= raiz; i:= i0; c:= k(i); indice:= 0;
      while indice < k'Length and p.ti(c)/= null loop
         p:= p.ti(c); i:= i+1; c:= k(i); indice:= indice+1;
      end loop;
      return c=mk and then p.ti(mk).t=hoja;
   end existe;

   procedure poner(t: in out trie; k: in key; x: in Unbounded_String) is
      raiz: pnodo renames t.raiz;
      p, r: pnodo;
      i: key_index;
      c: key_codi;
      indice: Integer;
   begin
      if existe(t, k) then raise ya_existe; end if;
      p:= raiz; i:= i0; c:= k(i); indice := 0;
      -- Dado el código, vamos mirando si existe el camino.
      -- En caso de que no existe un puntero válido para ese k(i)
      -- tenemos que crear un nuevo nodo interior, es decir, un nuevo
      -- array de key_codi, para hacer que la posicion k(i) apunte a ese nuevo
      -- nodo. A partir de ahi hasta el último k(i) se irán creando nodos interiores
      -- Una vez lleguemos al último k(i), tendremos que crear un nuevo nodo
      -- de tipo hoja y hacer que la marca mk del último nodo interior apunte ahí que
      -- será nuestro elemento

      while indice < k'Length loop
         if p.ti(c)=null then
            r:= new nodo(interior);
            r.ti:= (others => null);
            p.ti(c):= r;
         end if ;
         p:= p.ti(c); i:= i+1; c:= k(i); indice:= indice+1;
      end loop;
      r:= new nodo(hoja);
      r.nombre:=x;

      -- Nuestro elemento tiene un array de comentarios. Este array contiene cada
      -- uno una cola de comentarios, la cual se tiene que iniciarlizar cada
      -- vez que se introduce un elemento.
      for q in tqualificacio'Range loop
         cvacia(r.c(q));
      end loop;

      -- En nuestro nodo interior, tenemos que hacer que la mk apunte a nuestro
      -- elemento. Des esta forma sabemos que si mk/= null, es que para este
      -- código tenemos un elemento
      p.ti(mk):= r;
   exception
      when storage_error => raise espacio_desbordado;
   end poner;

   function unico_desc(p: in pnodo) return boolean is
      c: key_codi;
      nd: integer; -- numero de descendientes
   begin
      c:= mk; nd:= 0;
      while c/=lastc and nd<2 loop
         if p.ti(c)/= null then nd:= nd+1; end if ;
         c:= key_codi'succ(c);
      end loop;
      -- comprobar el ultimo caso c=lastc
      if p.ti(c)/= null then nd:= nd+1; end if ;
      return nd<2;
   end unico_desc;

   procedure borrar(t: in out trie; k: in key) is
      raiz: pnodo renames t.raiz;
      p, r: pnodo;
      i: key_index;
      c, cr: key_codi;
      indice: Integer;
   begin
      if not existe(t, k) then raise no_existe; end if;
      p:= raiz; i:= i0; c:= k(i); r:= p; cr:= c; indice:= 0;
      while indice < k'Length and p.ti(c)/= null loop
         if not unico_desc(p) then r:= p; cr:= c; end if ;
         p:= p.ti(c); i:= i+1; c:= k(i); indice := indice+1;
      end loop;
      if c=mk and then p.ti(mk).t=hoja then
         if unico_desc(p) then r.ti(cr):= null;
         else p.ti(mk):= null;
         end if ;
      end if ;
   end borrar;

   -- Necesitamos estas funciones del Iterador para poder devolver la lista
   -- de elementos de la carta
   procedure firstbranch(p: in pnodo; c: out key_codi; found: out boolean) is
   begin
      c:= mk; found:= (p.ti(c)/=null);
      while c < lastc and not found loop
         c:= key_codi'succ(c);
         found:= (p.ti(c)/=null);
      end loop;
   end firstbranch;

   procedure first (t: in trie; it: out iterator) is
      raiz: pnodo renames t.raiz;
      pth: path renames it.pth;
      k: key renames it.k;
      i: key_index renames it.i;
      c: key_codi;
      p: pnodo;
      found: boolean;
      indice: Integer;
   begin
      p:= raiz; i:= i0;
      firstbranch(p, c, found);
      indice := 0;
      while found and indice < k'Length loop
         pth(i):= p; k(i):= c; i:= i+1; indice := indice+1;
         p:= p.ti(c);
         firstbranch(p, c, found);
      end loop;
      pth(i):= p; k(i):= mk;
   end first;
   procedure nextbranch(p: in pnodo; c: in out key_codi; found: out boolean) is
   begin
      found:= false;
      while c < lastc and not found loop
         c:= key_codi'succ(c);
         found:= (p.ti(c)/=null);
      end loop;
   end nextbranch;

   procedure next(t: in trie; it: in out iterator) is
      raiz: pnodo renames t.raiz;
      pth: path renames it.pth;
      k: key renames it.k;
      i: key_index renames it.i;
      c: key_codi;
      p: pnodo;
      found: boolean;
   begin
      if k(i0)=mk then raise mal_uso; end if ;
      p:= pth(i); c:= k(i);
      nextbranch(p, c, found);
      while not found and i>1 loop
         i:= i-1; p:= pth(i); c:= k(i);
         nextbranch(p, c, found);
      end loop;
      while found and c/=mk loop
         pth(i):= p; k(i):= c; i:= i+1;
         p:= p.ti(c);
         firstbranch(p, c, found);
      end loop;
      pth(i):= p; k(i):= mk;
   end next;

   function is_valid(it: in iterator) return boolean is
      k: key renames it.k;
   begin
      return k(i0)/=mk;
   end is_valid;

   procedure get(t: in trie; it: in iterator; x: out Unbounded_String) is
      i: key_index renames it.i;
      pth: path renames it.pth;
   begin
      if it.k(i0)=mk then raise mal_uso; end if;
      --k:= it.k;
      x:= pth(i).ti(mk).nombre;
   end get;


   -- Metodos de comentarios

   procedure poner_comentario_elemento(t: in trie; k: in key; q : in tqualificacio; c: in Unbounded_String) is
      raiz: pnodo renames t.raiz;
      p: pnodo;
      i: key_index;
      kc: key_codi;
      indice: Integer;
   begin
      -- Bucle del existe
      p:= raiz; i:= i0; kc:= k(i); indice:= 0;
      while indice < k'Length and p.ti(kc)/= null loop
         p:= p.ti(kc); i:= i+1; kc:= k(i); indice:= indice+1;
      end loop;

      if kc=mk and then p.ti(mk).t=hoja then
         poner(p.c(q), c);
      else
         raise no_existe;
      end if;

      -- getCola(t, k, q, queue);


   end poner_comentario_elemento;

   procedure consultar_comentario_elemento(t: in trie; k: in key; q : in tqualificacio; c: out Unbounded_String) is
     raiz: pnodo renames t.raiz;
      p: pnodo;
      i: key_index;
      kc: key_codi;
      indice: Integer;
   begin
      -- Bucle del existe
      p:= raiz; i:= i0; kc:= k(i); indice:= 0;
      while indice < k'Length and p.ti(kc)/= null loop
         p:= p.ti(kc); i:= i+1; kc:= k(i); indice:= indice+1;
      end loop;

      if kc=mk and then p.ti(mk).t=hoja then
         c:= coger_primero(p.c(q));
      else
         raise mal_uso;
      end if;
   end consultar_comentario_elemento;


   function existe_comentario_elemento(t: in trie; k: in key; q : in tqualificacio) return boolean is
      raiz: pnodo renames t.raiz;
      p: pnodo;
      i: key_index;
      c: key_codi;
      indice: Integer;
   begin
      -- Bucle del existe
      p:= raiz; i:= i0; c:= k(i); indice:= 0;
      while indice < k'Length and p.ti(c)/= null loop
         p:= p.ti(c); i:= i+1; c:= k(i); indice:= indice+1;
      end loop;

      if c=mk and then p.ti(mk).t=hoja then
         return esta_vacia(p.c(q));
      end if;

      return False;

   end existe_comentario_elemento;


   procedure borrar_comentario_elemento(t: in trie; k: in key; q : in tqualificacio) is
   raiz: pnodo renames t.raiz;
      p: pnodo;
      i: key_index;
      c: key_codi;
      indice: Integer;
   begin
      -- Bucle del existe
      p:= raiz; i:= i0; c:= k(i); indice:= 0;
      while indice < k'Length and p.ti(c)/= null loop
         p:= p.ti(c); i:= i+1; c:= k(i); indice:= indice+1;
      end loop;

      if c=mk and then p.ti(mk).t=hoja then
         borrar_primero(p.c(q));
      else
         raise mal_uso;
      end if;

   end borrar_comentario_elemento;


end packageCategoria;
