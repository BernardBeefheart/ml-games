remember
========

Ce répertoire porte bien son nom, les programmes sont disont des exercices de _révision_, en effet, ce n'est pas la première fois que je fricotte avec les langages de la famille _ML_.

closure.sml
-----------

Un premier exemple de fermeture, ici un compteur.

continuations.sml
-----------------

Quelques essais (malheureux pour le moment) sur les continuations.

fibo.sml et fibo.fs
-------------------

Un calcul de la suite de Fibonacci avec _mémoïsation_. Il y a la version _standard ML_ (__fibo.sml__) et la version _F#_ (fibo.fs) avec, à quelques détails près, les mêmes fonctionnalités et la même structure.

De cette manière on voit bien les différences entre ces deux branches de _ML_.

remember.sml
------------

C'est le premier programme que j'ai écrit. Très simple au début, il s'est étoffé de ce dont j'avais besoin. Il calcul les factorielles.

__Note__: cette version ne compile pas pour un problème de signature.

TestSig.sml
-----------

Pour m'entrîner avec les signatures...

les fichiers _.mlb_ et _Makefile_
---------------------------------

Le __Makefile__ permet de compiler tout ce petit monde avec _F#_ ou __mlton__ tandis que les fichiers __.mlb__ sont les fichiers de compilations pour __mlton__.

Les exécutables et les fichiers temporaires se retrouvent dans un sous-répertoire nommé _o_. Les cibles de compilation sont :

*  _fsexes_: compilations avec _F#_ des sources en _*.fs_,
*  _smlexes_ : complations avec _mlton_ des sources en _*.sml_ à l'aides des fichiers _*.mlb_,
*  _all_ : les deux cibles précédentes,
*  _clean_ : nettoie les exécutables et les éventuels résidus de compilation.

__Note importante__ : __Makefile__ est fait pour la version _GNU_ de _make_. Cela signifie que sous BSD, il faut utiliser _gmake_.

