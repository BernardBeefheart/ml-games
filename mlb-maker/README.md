mlb-maker
=========

Des outils en ligne  de commande pour créer les fichiers nécessaires à un projet _ML_. Pour l'instant, le script __mlb-maker.sh__ est seul capable de faire correctement ce qu'on lui demande.

mlb-maker.sh
------------

Voici l'aide proposée :

	mlb-maker.sh [--help] : this text
	mlb-maker.sh --files files ... --libs libs ... --name mlbname

Le script a besoin de trois groupes de paramètres :

* _--files_ : l'ensemble des fichiers sources,
* _--libs_ : l'ensemble des fichiers bibliothèques,
* _--name_ : le nom des fichier __.mlb__ et __.sml__ produits.

Voici un bon exemple de session :

	b@pcbsd-10 ~ (git)-[master] % mlb-maker.sh
	mlb-maker.sh [--help] : this text
	mlb-maker.sh --files files ... --libs libs ... --name mlbname
	b@pcbsd-10 ~ (git)-[master] % mlb-maker.sh \
		--files aidemoi.sml cesttout.sml adieu.sml main.sml \
		--libs ../leslibs/LaBelle.sml \
		--name cestbon
	cestbon.mlb done
	b@pcbsd-10 ~ (git)-[master] %

En sortie, nous avons les deux fichiers __cestbon.mlb__ :
	 * cestbon.mlb
	 * generated on sam 23 aoû 2014 23:46:28 CEST by bernard
	 *)

	local
		(* import Basis Library *)
		$(SML_LIB)/basis/basis.mlb
		../leslibs/LaBelle.sml
	in
		structure LaBelle
		aidemoi.sml
		cesttout.sml
		adieu.sml
		main.sml
	end

	
et __cestbon.sml__ :

	(*
	 * cestbon.sml
	 * generated on sam 23 aoû 2014 23:46:28 CEST by bernard
	 *)

	 open LaBelle.sml;

	fun main () =
			0;

	main ();

Avec tout cela, un __mlton cestbon.mlb__ devrait compiler sans erreurs - si la bibliothèque __LaBelle.sml__ ne pose pas de problèmes.	
