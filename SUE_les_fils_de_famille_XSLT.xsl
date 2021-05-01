<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <!-- Exclusion des préfixes TEI avec exclude-result-prefixes -->

    <!-- On configure l'output HTML, avec indentation automatique et encodage en UTF-8 -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- On évite les espaces non voulus -->
    <xsl:strip-space elements="*"/>

    <!-- On configure les sorties HTML -->

    <xsl:template match="/">
        <!-- On stocke le nom le chemin du fichier courant -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), 'SUE_les_fils_de_famille.xml', '')"/>
        </xsl:variable>

        <!-- Pour chaque output HTML de l'édition numérique, on crée une variable qui stocke le chemin de l'output, en concaténant la variable witfile crée précédemment. -->
        <xsl:variable name="path_homepage">
            <xsl:value-of select="concat($witfile, 'html/homepage', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_pers_index">
            <xsl:value-of select="concat($witfile, 'html/pers_index', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_place_index">
            <xsl:value-of select="concat($witfile, 'html/place_index', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_relationships">
            <xsl:value-of select="concat($witfile, 'html/relationships', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_transcription">
            <xsl:value-of select="concat($witfile, 'html/transcription', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_original_edition">
            <xsl:value-of select="concat($witfile, 'html/original_edition', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_analysis">
            <xsl:value-of select="concat($witfile, 'html/analysis', '.html')"/>
        </xsl:variable>

        <xsl:variable name="path_about">
            <xsl:value-of select="concat($witfile, 'html/about', '.html')"/>
        </xsl:variable>


        <!-- BRIQUES DE CONSTRUCTION DES SORTIES HTML -->

        <!-- On crée le head HTML -->
        <xsl:variable name="head">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <meta name="description"
                    content="Projet d'édition numérique du roman-feuilleton les Fils de famille d'Eugène Sue (1856)"/>
                <meta name="keywords" content="edition, tei, xslt, roman-feuilleton"/>
                <meta name="author" content="Hugo Scheithauer"/>
                <title>
                    <!-- On récupère le titre de l'oeuvre littéraire encodée directement dans le XML source -->
                    <xsl:value-of
                        select="concat(//sourceDesc//titleStmt/title, ', ', //sourceDesc//forename, ' ', //sourceDesc//surname)"
                    />
                </title>
                <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"/>
                <link
                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
                    rel="stylesheet"
                    integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
                    crossorigin="anonymous"/>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"/>
            </head>
        </xsl:variable>

        <!-- On crée une barre de navigation -->
        <xsl:variable name="nav_bar">
            <nav class="navbar navbar-expand-md navbar-dark bg-dark justify-content-between">
                <a class="navbar-brand" style="padding-left: 5px" href="{$path_homepage}">
                    <!-- On récupère le prénom et nom de l'auteur, et le titre de l'oeuvre dans la source XML -->
                    <xsl:value-of
                        select="concat(//sourceDesc//titleStmt/title, ', ', //sourceDesc//forename, ' ', //sourceDesc//surname)"
                    />
                </a>
                <!-- Pour chaque output HTML, on crée un lien de navigation dans la barre de navigation -->
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <!-- On récupère une variable entre {}. Les variables suivantes étant les chemins de fichier des différents outputs. -->
                        <a class="nav-link" href="{$path_original_edition}">Edition d'origine</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_transcription}">Transcription</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_pers_index}">Index des personnages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_place_index}">Index des noms de lieux</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_relationships}">Relations entre les
                            personnages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_analysis}">Analyses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_about}">A propos</a>
                    </li>
                </ul>
            </nav>
        </xsl:variable>

        <!-- On crée un footer pour la mise en page -->
        <xsl:variable name="footer">
            <footer class="text-center text-white" style="background-color: #f1f1f1;">
                <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
                    <p>Hugo Scheithauer - 2021</p>
                </div>
            </footer>
        </xsl:variable>

        <!-- SORTIES HTML -->
        <!-- Avec xsl:result-document, on écrit les règles de transformation pour les output
        Ici, on crée l'output HTML correspondant à la page d'accueil. -->
        <!-- @href permet d'indiquer le chemin du fichier de sortie
        @method indique ici que la sortie sera en HTML
        @indent="yes" permet d'indiquer qu'on attend du HTML indenté -->
        <xsl:result-document href="{$path_homepage}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div style="padding: 20px;">
                        <figure>
                            <a href="https://gallica.bnf.fr/ark:/12148/bpt6k58180814/f8.item">
                                <img class="rounded mx-auto d-block"
                                    src="../image/illustration_fils_de_famille_p1.png"
                                    style="width: 38rem; height: auto"/>
                            </a>
                            <figcaption style="text-align:center;">Image d'illustration des Fils de
                                famille, folio 8, édition Michel Lévy Frères, 1862</figcaption>
                        </figure>
                    </div>
                    <div class="container">
                        <div style="text-align: center; padding-top: 20px;">
                            <p>Bienvenue dans ce projet d'édition numérique du roman-feuilleton
                                    <i>Les Fils de famille</i> d'Eugène SUE.</p>
                            <p>
                                <xsl:value-of select="//encodingDesc"/>
                            </p>
                            <!-- Pour créer un lien renvoyant à l'édition d'origine sur Gallica, on récupère l'attribut @facs de <distributor> dans la source XML, et on l'injecte comme attribut HTML dans la balise <a> grâce aux {} -->
                            <p>Ce projet présente les pages 2 à 5 du roman. La numérisation est
                                disponible sur <a
                                    href="https://gallica.bnf.fr/accueil/en/content/accueil-en?mode=desktop"
                                    >Gallica</a> à cette <a
                                    href="{//sourceDesc//publicationStmt/distributor/@facs}"
                                    >adresse</a>.</p>
                            <p>Cette édition propose d'enrichir la lecture de l'oeuvre originale en
                                analysant le rapport des personnages par une analyse
                                statistique.</p>
                            <p>Vous pouvez naviguer à travers le projet grâce à la barre de
                                navigation en haut de cette page. Bonne visite !</p>
                        </div>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>

        <!-- On crée l'index des personnages -->
        <xsl:result-document href="{$path_pers_index}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1>Index des noms de personnages</h1>
                        <ul>
                            <!-- On appelle une xsl:template créée plus bas grâce à l'attribut @name. -->
                            <xsl:call-template name="pers_index"/>
                        </ul>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>

        <xsl:result-document href="{$path_place_index}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1>Index des noms de lieux</h1>
                        <ul>
                            <xsl:call-template name="place_index"/>
                        </ul>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>

        <!-- On crée la sortie HTML pour afficher les informations de l'édition originale -->
        <xsl:result-document href="{$path_original_edition}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1>Informations bibligraphiques de l'édition d'origine</h1>
                        <ul>
                            <li>Titre : <xsl:value-of select="//biblFull/titleStmt/title"/></li>
                            <!-- On utilise la fonction concat() pour concaténer plusieurs chaînes de caractères afin de mettre en page les informations. -->
                            <li>Auteur : <xsl:value-of
                                    select="concat(//biblFull/titleStmt//forename, ' ', //biblFull/titleStmt//surname)"
                                /></li>
                            <li>Maison d'édition : <xsl:value-of
                                    select="concat(//biblFull/publicationStmt/publisher, ' (', //biblFull//settlement, ', ', //biblFull//postCode, ', ', //biblFull//street, ')')"
                                /></li>
                            <li>Date d'édition : <xsl:value-of select="//biblFull//date"/></li>
                            <li>Mise à disposition par : <a href="{//biblFull//distributor/@facs}"
                                        ><xsl:value-of select="//biblFull//distributor"/></a></li>
                        </ul>
                    </div>
                    <div class="container">
                        <h1>Localisation de l'extrait dans l'oeuvre originale</h1>
                        <ul>
                            <!-- On sélectionne des éléments XML en testant leur attribut @unit.
                            Par exemple, le premier <xsl:value> récupère la valeur de l'élément <biblScope unit="part"> -->
                            <li>Partie : <xsl:value-of
                                    select="//biblFull/seriesStmt/biblScope[@unit = 'part']"/></li>
                            <li>Chapitre : <xsl:value-of
                                    select="//biblFull/seriesStmt/biblScope[@unit = 'chapter']"
                                /></li>
                            <li>Pages : <xsl:value-of
                                    select="//biblFull/seriesStmt/biblScope[@unit = 'page']"/></li>
                        </ul>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>

        <!-- On crée la sortie HTML de la transcription -->
        <xsl:result-document href="{$path_transcription}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <xsl:element name="div">
                            <xsl:apply-templates select="//body"/>
                        </xsl:element>

                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>

        <!-- On crée la page HTML pour les analyses statistiques -->
        <!-- Pour les analyses statistiques, on utilise la librairie JavaScript "Google Charts" permettant de réaliser des diagrammes. -->
        <xsl:result-document href="{$path_analysis}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container d-flex justify-content-center">
                        <h1>Analyses statistiques de l'extrait encodé</h1>
                    </div>
                    <div class="container">
                        <div class="d-flex justify-content-center" id="SpeechDistributionChart"/>
                    </div>
                    <div class="container">
                        <table class="columns">
                            <caption style="caption-side:top;">Répartition des mentions des
                                personnages dans tous les dialogues selon les personnages</caption>
                            <tr>
                                <td>
                                    <div style="margin:10px; border: 1px solid #ccc"
                                        id="GenevieveSpeechDistributionChart"/>
                                </td>
                                <td>
                                    <div style="margin:10px; border: 1px solid #ccc"
                                        id="CharlesDelmareSpeechDistributionChart"/>
                                </td>
                                <td>
                                    <div style="margin:10px; border: 1px solid #ccc"
                                        id="PereDelmareSpeechDistributionChart"/>
                                </td>
                            </tr>
                        </table>
                        <div style="margin:10px; border: 1px solid #ccc" id="test"/>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
                <!-- Ci-dessous, le script JavaScript permettant l'affichage des diagrammes. -->
                <script type="text/javascript">
                    google.charts.load('current', {
                        'packages':[ 'corechart']
                    });
                    google.charts.setOnLoadCallback(drawSpeechDistributionChart);
                    google.charts.setOnLoadCallback(drawGenevieveSpeechDistributionChart);
                    google.charts.setOnLoadCallback(drawCharlesDelmareSpeechDistributionChart);
                    google.charts.setOnLoadCallback(drawPereDelmareSpeechDistributionChart);
                    
                    
                    // Premier diagramme concernant la répartition de l'espace de parole
                    function drawSpeechDistributionChart() {
                        var data = google.visualization.arrayToDataTable([[ 'Task', "Distribution de l'espace de parole"],<xsl:for-each select="//listPerson/person">
                        <xsl:variable name="person">
                            <xsl:value-of select="persName"/>
                        </xsl:variable>
                        <xsl:variable name="person_id">
                            <xsl:value-of select="./@xml:id"/>
                        </xsl:variable>
                        ['<xsl:value-of select="$person"/>', <xsl:value-of select="count(//said[@who = concat('#', $person_id)])"/>]<xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
]);
                    
                    // Les valeurs récupérées grâce à cette boucle auraient pu être récupérées grâce à un count(). Cependant, dans le cas où il y
                    // aurait un nombre important de personnages, on peut imaginer qu'il serait chronophage de les lister un par un. Cette boucle
                    // s'en occupe donc, mais a pour ici valeur de démonstration. Des utilisations de count() sont effectuées plus bas.
                    // On utilise un xsl:if pour construire un array JavaScript valide
                    
                    var options = {
                        'title': "Distribution de l'espace de parole", 'width': 550, 'height': 400
                    };
                    
                    var chart = new google.visualization.PieChart(document.getElementById('SpeechDistributionChart'));
                    chart.draw(data, options);
                }
                
                // Diagramme affichant la répartition des mentions des personnages dans l'intégralité des dialogues de Geneviève, elle y comprise.
                
                
                function drawGenevieveSpeechDistributionChart() {
                    var data = google.visualization.arrayToDataTable([[ 'Task', "Répartition des mentions des personnages dans l'intégralité des dialogues de Geneviève, elle y comprise"],[ 'Geneviève',<xsl:value-of select="count(//said[@who = '#Geneviève']//rs[@ref = '#Geneviève'])"/>
],[ 'Charles Delmare',<xsl:value-of select="count(//said[@who = '#Geneviève']//rs[@ref = '#Charles_Delmare'])"/>
],[ 'Le père Delmare',<xsl:value-of select="count(//said[@who = '#Geneviève']//rs[@ref = '#père_Delmare'])"/>
],]);
                    
                    // Pour récupérer les valeurs à partir des balises rs, on utilise la fonction count() qui va compter le nombre d'occurence
                    
                    var options = {
                        'title': "Répartition des mentions des personnages dans l'intégralité des dialogues de Geneviève, elle y comprise", 'width': 400, 'height': 400
                    };
                    
                    var chart = new google.visualization.PieChart(document.getElementById('GenevieveSpeechDistributionChart'));
                    chart.draw(data, options);
                }
                
                // Diagramme affichant la répartition des mentions des personnages dans l'intégralité des dialogues de Charles Delmare, lui y compris.
                
                function drawCharlesDelmareSpeechDistributionChart() {
                    var data = google.visualization.arrayToDataTable([[ 'Task', "Répartition des mentions des personnages dans l'intégralité des dialogues de Charles Delmare, lui y compris"],[ 'Geneviève',<xsl:value-of select="count(//said[@who = '#Charles_Delmare']//rs[@ref = '#Geneviève'])"/>
],[ 'Charles Delmare',<xsl:value-of select="count(//said[@who = '#Charles_Delmare']//rs[@ref = '#Charles_Delmare'])"/>
],[ 'Le père Delmare',<xsl:value-of select="count(//said[@who = '#Charles_Delmare']//rs[@ref = '#père_Delmare'])"/>
]]);
                    
                    var options = {
                        'title': "Répartition des mentions des personnages dans l'intégralité des dialogues de Charles Delmare, lui y compris", 'width': 400, 'height': 400
                    };
                    
                    var chart = new google.visualization.PieChart(document.getElementById('CharlesDelmareSpeechDistributionChart'));
                    chart.draw(data, options);
                }
                
                // Diagramme affichant la répartition des mentions des personnages dans l'intégralité des dialogues du père Delmare, lui y compris.
                
                function drawPereDelmareSpeechDistributionChart() {
                    var data = google.visualization.arrayToDataTable([[ 'Task', "Répartition des mentions des personnages dans l'intégralité des dialogues du père Delmare, lui y compris"],[ 'Geneviève',<xsl:value-of select="count(//said[@who = '#père_Delmare']//rs[@ref = '#Geneviève'])"/>
],[ 'Charles Delmare',<xsl:value-of select="count(//said[@who = '#père_Delmare']//rs[@ref = '#Charles_Delmare'])"/>
],[ 'Le père Delmare',<xsl:value-of select="count(//said[@who = '#père_Delmare']//rs[@ref = '#père_Delmare'])"/>
]]);
                    
                    var options = {
                        'title': "Répartition des mentions des personnages dans l'intégralité des dialogues du père Delmare, lui y compris", 'width': 400, 'height': 400
                    };
                    
                    var chart = new google.visualization.PieChart(document.getElementById('PereDelmareSpeechDistributionChart'));
                    chart.draw(data, options);
                }
                
                
                // Etant donné que dans l'extrait encodé les trois personnages n'interagissent pas tous et toutes entre eux (Charles Delmare ne// parle qu'à Geneviève, le père Delmare ne parle qu'à Geneviève, Geneviève adresse la parole, indirectement, au père Delmare qu'une// seule fois), il n'est pas pertinent à ce stade de faire des diagrammes de répartition des mentions dans les dialogues selon à qui// s'adresse le personnage. On préfère se contenter des diagrammes indiquant les mentions dans l'intégralité des dialogues.</script>
            </html>
        </xsl:result-document>

        <!-- On crée la sortie HTML pour afficher les relations entre les personnages -->
        <xsl:result-document href="{$path_relationships}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <div style="text-align: center; padding-top: 20px;">
                            <h1>Relations entre les personnages</h1>
                            <br/>
                            <!-- On utilise une boucle xsl:for-each pour former une structure HTML pour chaque l<istRelation> -->
                            <xsl:for-each select="//listRelation">
                                <h2>
                                    <xsl:value-of select="./@type"/>
                                </h2>
                                <!-- Etant donné qu'une <listRelation> peut contenir plusieurs <relation>, on crée une boucle for-each pour toutes les traiter. L'encodage XML utilisé pour la transformation ne comprend pas plusieurs <relation> dans les <listRelation>, cependant, cette structure a tout de même mise en place dans le cas où cela serait nécessaire. Cette structure a donc valeur de démonstration. -->
                                <xsl:for-each select="./relation">
                                    <dl>
                                        <dt>Personnages</dt>
                                        <xsl:choose>
                                            <!-- On utilise xsl:choose pour tester si <relation> comprend un attribut @ active. Si cela est le cas, cela sous-entend la majeure partie du temps l'exitence d'un attribut @passive. -->
                                            <xsl:when test="./@active">
                                                <!-- On récupère les valeurs des attributs @active et @passive pour récupérer les persName plus tard. -->
                                                <xsl:variable name="id_active">
                                                    <!-- On transforme le pointeur avec replace() -->
                                                  <xsl:value-of select="./replace(@active, '#', '')"
                                                  />
                                                </xsl:variable>
                                                <xsl:variable name="id_passive">
                                                  <xsl:value-of
                                                  select="./replace(@passive, '#', '')"/>
                                                </xsl:variable>
                                                <dd><xsl:value-of
                                                  select="//person[@xml:id = $id_active]/persName"/>
                                                  &#8594; <xsl:value-of
                                                  select="//person[@xml:id = $id_passive]/persName"
                                                  /></dd>
                                            </xsl:when>
                                            <!-- Si <relation> ne possède pas d'attribut @active, alors c'est qu'il y a probablement un attribut @mutual, que l'on va traiter ici. -->
                                            <xsl:otherwise>
                                                    <!-- On utilise la fonction XPath translate() pour remplacer le # et le _ par un espace -->
                                                    <!-- On ne transforme pas les pointeurs par commodité, la chaîne de caractère comprenant en effet deux pointeurs, difficile à traiter et à séparer en deux entités séparées qu'on pourrait exploiter plus tard. On se contente donc du pointeur pour afficher le nom des personnages. Cette solution est applicable à @active et @passive également, l'output étant finalement le même. Cette technique a l'avantage de ne pas nécessiter la création de variable. -->
                                                <dd>
                                                    <xsl:value-of select="./translate(@mutual, '#_', '  ')"/>
                                                </dd>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <dt>Type de relation</dt>
                                        <dd>
                                            <xsl:value-of select="./@name"/>
                                        </dd>
                                    </dl>
                                </xsl:for-each>
                            </xsl:for-each>
                        </div>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>

    </xsl:template>

    <!-- Templates -->

    <!-- Template d'affichage de l'index des personnages -->
    <xsl:template name="pers_index">
        <!-- On écrit une boucle for-each pour pouvoir trier par ordre alphabétique les personnages avec xsl:sort -->
        <xsl:for-each select="//listPerson/person">
            <xsl:sort select="./persName" order="ascending"/>
            <li>
                <xsl:value-of select="concat(persName, ' : ', note)"/>
            </li>
        </xsl:for-each>
    </xsl:template>

    <!-- Template d'affichage de l'index des noms de lieux -->
    <xsl:template name="place_index">
        <!-- On utilise une boucle for-each pour pouvoir créer une mise en page en fonction des informations disponibles pour chaque lieu. -->
        <xsl:for-each select="//listPlace/place">
            <xsl:sort select=".//name"/>
            <li>
                <xsl:value-of select="placeName//name"/>

                <xsl:value-of select="concat(' (', @type, ')')"/>

                <!-- Si le lieu a une information de région (!= 'none', dans l'encodage XML), on la récupère, sinon, on ne fait rien.. -->
                <xsl:if test="placeName//region != 'none'">
                    <xsl:value-of select="concat(', ', placeName//region)"/>
                </xsl:if>

                <!-- Si le lieu a une information de note, on la récupère. Sinon, on met directement un '.' -->
                <xsl:choose>
                    <xsl:when test="note">
                        <xsl:value-of select="concat(' : ', note)"/>
                    </xsl:when>
                    <xsl:otherwise>.</xsl:otherwise>
                </xsl:choose>
            </li>
        </xsl:for-each>
    </xsl:template>

    <!-- Règles pour afficher la transcription -->
    <!-- On traite les <head> des <div> de premier niveau -->
    <xsl:template match="//body/div/head">
        <xsl:element name="h1">
            <xsl:attribute name="class">text-center</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <!-- On traite les <head> des <div> de deuxième niveau -->
    <xsl:template match="//body/div/div/head">
        <xsl:element name="h2">
            <xsl:attribute name="class">text-center</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <!-- On traite les <head> des <div> de troisième niveau -->
    <xsl:template match="//body/div/div/div/head">
        <xsl:element name="h3">
            <xsl:attribute name="class">text-center</xsl:attribute>
            <xsl:copy>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:element>
    </xsl:template>

    <!-- On traite les <p> -->
    <xsl:template match="//body//p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- On traite les <gap> -->
    <xsl:template match="//gap">
        <xsl:element name="p">
            <xsl:attribute name="class">text-danger</xsl:attribute>
            <u>Manque dans la version numérisée : <xsl:value-of select="//gap/desc"/></u>
        </xsl:element>
    </xsl:template>

    <!-- On traite les <emph> dans les <p> pour que l'affichage soit également en italique dans la sortie HTML -->
    <xsl:template match="emph[@rend = 'italic']">
        <xsl:element name="i">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
