<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <!--Kim Steen Ravn for Grundtvigs Værker -->

    <xsl:template match="TEI:TEI">
        
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="txtCSS.css"/>
                <link rel="stylesheet" type="text/css" href="editCSS.css"/>
                <meta http-equiv="Content-type" content="text/html; charset=UFT-8"/>
                <title>
                    <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='shortForm']"/>
                </title>
            </head>
            <body>
                
                <div class="version">
                    <div style="text-align: center">
                        <xsl:text>Til kontrol af &lt;teiHeader&gt;</xsl:text>
                    </div>
                    <div>
                        <xsl:text>content: </xsl:text><xsl:value-of select="//TEI:idno[@type='content']"/>
                        <br/>
                        <xsl:text>technic: </xsl:text><xsl:value-of select="//TEI:idno[@type='technic']"/>
                        <br/>
                        <xsl:text>dato: </xsl:text><xsl:value-of select="//TEI:date/@when"/>
                        <br/>
                        <xsl:text>upload: </xsl:text><xsl:value-of select="//TEI:date[@when]/text()"/>
                        <xsl:choose>
                            <xsl:when test="//TEI:note[@type='noBible' or @type='noMyth' or @type='noPersName' or @type='noPlaceName' or @type='noTitle']">
                                <div style="font-weight: bold; margin-top: 1em">
                                    <xsl:text>Status for opmærkning til registre:</xsl:text>
                                </div>
                                <div>
                                    <xsl:if test="//TEI:note[@type='noBible']">
                                        <xsl:text>&#x2003;ikke færdig til bible.xml</xsl:text>
                                    </xsl:if>
                                </div>
                                <div>
                                    <xsl:if test="//TEI:note[@type='noMyth']">
                                        <xsl:text>&#x2003;ikke færdig til til myth.xml</xsl:text>
                                    </xsl:if>
                                </div>
                                <div>
                                    <xsl:if test="//TEI:note[@type='noPersName']">
                                        <xsl:text>&#x2003;ikke færdig til til pers.xml</xsl:text>
                                    </xsl:if>
                                </div>
                                <div>
                                    <xsl:if test="//TEI:note[@type='noPlaceName']">
                                        <xsl:text>&#x2003;ikke færdig til til place.xml</xsl:text>
                                    </xsl:if>
                                </div>
                                <div>
                                    <xsl:if test="//TEI:note[@type='noTitle']">
                                        <xsl:text>&#x2003;ikke færdig til title.xml</xsl:text>
                                    </xsl:if>
                                </div>
                            </xsl:when>
                        </xsl:choose>
                        <div>
                            <xsl:variable name="fileNameIntro">
                                <xsl:value-of select="document(//TEI:note[@type='intro' or @type='noIntro']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:notesStmt/TEI:note[@type='intro']/@target"/>
                            </xsl:variable>                                
                            <xsl:variable name="fileNameTxt">
                                <xsl:value-of select="//TEI:note[@type='intro' or @type='noIntro']/@target"/>
                            </xsl:variable>                                
                            <xsl:choose>
                                <xsl:when test="not($fileNameIntro=$fileNameTxt)">
                                    <span style="color: red"><xsl:text>Der er noget galt med filnavnet på indledningen!</xsl:text></span>
                                </xsl:when>
                            </xsl:choose>
                        </div>
                    </div>
                    
                    <!--div style="margin-top: 1em">
                        <div style="font-weight: bold;">
                            <xsl:text>Status for kommentarer:</xsl:text>
                        </div>
                        <table class="headControl">
                            <thead>
                                <td>Tekstfil</td>
                                <td>Kommentarfiler</td>
                            </thead>
                            <tr>
                                <td><xsl:apply-templates select="//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=2]/@type"/></td>
                                <td><xsl:apply-templates select="document(//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=2]/@target)//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=2]/@type"/></td>
                            </tr>
                            <tr>
                                <td><xsl:apply-templates select="//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=3]/@type"/></td>
                                <td><xsl:apply-templates select="document(//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=3]/@target)//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=last()]/@type"/></td>
                            </tr>
                            <tr>
                                <td><xsl:apply-templates select="//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=4]/@type"/></td>
                                <td><xsl:apply-templates select="document(//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=4]/@target)//TEI:notesStmt/TEI:note[not(@type='footnote' or @type='endNote' or @type='marginNote')][position()=2]/@type"/></td>
                            </tr>
                            <tr>
                                <td>
                                    <xsl:apply-templates select="//TEI:notesStmt/TEI:note[position()=5]/@type"/>
                                </td>
                                <td>
                                    <xsl:if test="//TEI:listWit[@xml:id='pageNumber']">
                                        <xsl:choose>
                                            <xsl:when test="//TEI:notesStmt/TEI:note[not(@type='minusVar')][position()=5]">
                                                <text>attributværdien <code><xsl:apply-templates select="//TEI:notesStmt/TEI:note[position()=5]/@type"/></code> skal rettes til <code>minusVar</code></text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text></xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        
                                    </xsl:if>
                                    <xsl:if test="//TEI:listWit[not(@xml:id='pageNumber')]">
                                        <text></text>
                                    </xsl:if>
                                </td>
                            </tr>
                        </table>
                    </div-->
                </div>
                
                <div class="kolofonBlad">
                    
                    <div class="kolofonTitle">
                        <xsl:choose>
                            <xsl:when test="//TEI:titleStmt/TEI:author">
                                <xsl:call-template name="author"/>
                            </xsl:when>
                            <xsl:when test="//TEI:titleStmt/TEI:editor[@role='editor1' or @role='editor2']">
                                <xsl:call-template name="editor"/>
                            </xsl:when>
                        </xsl:choose>
                    </div>
                    
                    <!--div class="kolofonTitle">
                        <xsl:text>Kortform: </xsl:text>
                        <xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='shortForm']"/>
                    </div-->
                    
                    <div class="kolofon">
                        <xsl:choose>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='0.9'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 0.9, marts 2011</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.0'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.0, maj 2012</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.1'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.1, november 2012</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.2'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.2, maj 2013</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.3'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.3, oktober 2013</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.4'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.4, maj 2014</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.5'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.5, oktober 2014</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.6'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.6, maj 2015</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.7'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.7, november 2015</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.8'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.8, april 2016</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.9'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.9, november 2016</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.10'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.10, maj 2017</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.11'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.11, november 2017</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.12'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.12, april 2018</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.13'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.13, november 2018</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.14'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.14, april 2019</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.15'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.15, november 2019</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:when test="//TEI:idno[@type='firstUpload']='1.16'">
                                <xsl:text>Offentliggjort første gang i</xsl:text> <i><xsl:text> Grundtvigs Værker</xsl:text></i> <xsl:text> version 1.16, april 2020</xsl:text>
                                <xsl:call-template name="changesContent"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <span style="color: red">
                                    <xsl:text>Versionsnummer for første version mangler!</xsl:text>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div><div class="kolofon">
                        
                        <xsl:variable name="addCom">
                            <xsl:if test="//TEI:idno[@type='addCom']">
                                <xsl:value-of select="//TEI:idno[@type='addCom']"/>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="addIntro">
                            <xsl:if test="//TEI:idno[@type='addIntro']">
                                <xsl:value-of select="//TEI:idno[@type='addIntro']"/>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="addTxr">
                            <xsl:if test="//TEI:idno[@type='addTxr']">
                                <xsl:value-of select="//TEI:idno[@type='addTxr']"/>
                            </xsl:if>                            
                        </xsl:variable>
                        
                        <xsl:variable name="dateAddVersion">
                            <xsl:if test="//TEI:idno[@type='addCom']">
                                <xsl:choose>
                                    <xsl:when test="//TEI:idno[@type='addCom']='0.9'">
                                        <xsl:text>, 3. marts 2011</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.0'">
                                        <xsl:text>, 15. maj 2012</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.1'">
                                        <xsl:text>, 15. november 2012</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.2'">
                                        <xsl:text>, 1. maj 2013</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.3'">
                                        <xsl:text>, 1. oktober 2013</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.4'">
                                        <xsl:text>, 1. maj 2014</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.5'">
                                        <xsl:text>, 31. oktober 2014</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.6'">
                                        <xsl:text>, 4. maj 2015</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.7'">
                                        <xsl:text>, 3. november 2015</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.8'">
                                        <xsl:text>, 29. april 2016</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.9'">
                                        <xsl:text>, 1. november 2016</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.10'">
                                        <xsl:text>, 3. maj 2017</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.11'">
                                        <xsl:text>, 1. november 2017</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="//TEI:idno[@type='addCom']='1.12'">
                                        <xsl:text>, 3. april 2018</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:choose>
                            <!-- 1 AAA -->
                            <xsl:when test="($addCom=$addIntro) and ($addIntro=$addTxr)">
                                <xsl:if test="$addCom!=''">
                                    <div>
                                        <xsl:text>Tilføjet punktkommentarer, indledning og tekstredegørelse i version </xsl:text><xsl:value-of select="$addCom"/>
                                        <xsl:choose>
                                            <xsl:when test="//TEI:idno[@type='addCom']">
                                                <xsl:choose>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='0.9'">
                                                        <xsl:text>, marts 2011</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.0'">
                                                        <xsl:text>, maj 2012</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.1'">
                                                        <xsl:text>, november 2012</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.2'">
                                                        <xsl:text>, maj 2013</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.3'">
                                                        <xsl:text>, oktober 2013</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.4'">
                                                        <xsl:text>, maj 2014</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.5'">
                                                        <xsl:text>, oktober 2014</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.6'">
                                                        <xsl:text>, maj 2015</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.7'">
                                                        <xsl:text>, november 2015</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.8'">
                                                        <xsl:text>, april 2016</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.9'">
                                                        <xsl:text>, november 2016</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.10'">
                                                        <xsl:text>, maj 2017</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.11'">
                                                        <xsl:text>, november 2017</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.12'">
                                                        <xsl:text>, april 2018</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="//TEI:idno[@type='addCom']='1.13'">
                                                        <xsl:text>, november 2018</xsl:text>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:when>
                                        </xsl:choose>
                                    </div>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <!-- 7 AAB -->
                                    <xsl:when test="$addCom=$addIntro">
                                        <xsl:if test="$addCom!=''">
                                            <div>
                                                <xsl:text>Tilføjet indledning og punktkommentarer i version </xsl:text><xsl:value-of select="$addCom"/>
                                                <xsl:call-template name="dateAddCom"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$addTxr!=''">
                                            <div>
                                                <xsl:text>Tilføjet tekstredegørelse i version </xsl:text><xsl:value-of select="$addTxr"/>
                                                <xsl:call-template name="dateAddTxr"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- 8 ABA -->
                                    <xsl:when test="$addCom=$addTxr">
                                        <xsl:if test="$addCom!=''">
                                            <div>
                                                <xsl:text>Tilføjet punktkommentarer og tekstredegørelse i version </xsl:text><xsl:value-of select="$addCom"/>
                                                <xsl:call-template name="dateAddCom"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$addIntro!=''">
                                            <div>
                                                <xsl:text>Tilføjet indledning i version </xsl:text><xsl:value-of select="$addIntro"/>
                                                <xsl:call-template name="dateAddIntro"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- 9 ABB -->
                                    <xsl:when test="$addIntro=$addTxr">
                                        <xsl:if test="$addCom!=''">
                                            <div>
                                                <xsl:text>Tilføjet punktkommentarer i version </xsl:text><xsl:value-of select="$addCom"/>
                                                <xsl:call-template name="dateAddCom"></xsl:call-template>
                                            </div>                                            
                                        </xsl:if>
                                        <xsl:if test="$addIntro!=''">
                                            <div>
                                                <xsl:text>Tilføjet indledning og tekstredegørelse i version </xsl:text><xsl:value-of select="$addIntro"/>
                                                <xsl:call-template name="dateAddIntro"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- 13 ABC -->
                                    <xsl:otherwise>
                                        <xsl:if test="$addCom!=''">
                                            <div>
                                                <xsl:text>Tilføjet punktkommentarer i version </xsl:text><xsl:value-of select="$addCom"/>
                                                <xsl:call-template name="dateAddCom"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$addIntro!=''">
                                            <div>
                                                <xsl:text>Tilføjet indledning i version </xsl:text><xsl:value-of select="$addIntro"/>
                                                <xsl:call-template name="dateAddIntro"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$addTxr!=''">
                                            <div>
                                                <xsl:text>Tilføjet tekstredegørelse i version </xsl:text><xsl:value-of select="$addTxr"/>
                                                <xsl:call-template name="dateAddTxr"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>                            
                        </xsl:choose>                        
                        <div style="margin: 0.5em 0em 0em 0em">
                            <xsl:call-template name="changeVersion"/>
                        </div>                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:text>Tekstkilder</xsl:text>                        
                        <tr>
                            <xsl:for-each select="//TEI:listWit[@xml:id='emendation']/TEI:witness">
                                <div class="table">
                                    <table class="listWit">
                                        <tr>
                                            <td class="sigel">
                                                <xsl:choose>
                                                    <xsl:when test="@xml:id='DU'">
                                                        <xsl:text>D&amp;U</xsl:text>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="@xml:id"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                            <td class="source">
                                                <xsl:choose>
                                                    <xsl:when test="@xml:id='A'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text>, </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:for-each select="TEI:num">
                                                                <xsl:value-of select="."/>
                                                                <xsl:if test="following-sibling::TEI:num">
                                                                    <xsl:choose>
                                                                        <xsl:when test="following-sibling::TEI:num[position()!=last()]">
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:text> og </xsl:text>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </span>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="starts-with(a,a)">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text>, </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='B'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text>, </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text> 
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='C'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text>, </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                        <xsl:text> (SJ: </xsl:text>
                                                        <xsl:apply-templates select="@n"/>
                                                        <xsl:text>)</xsl:text> 
                                                    </xsl:when>
                                                    <xsl:when test="not(@xml:id)">
                                                        <span class="descList">
                                                            <xsl:apply-templates/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='R'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='K'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='r'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='k'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='D&amp;U'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text> </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='Gskv'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text> </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='GSV'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text> </xsl:text>
                                                        </span>
                                                        <span class="num">
                                                            <xsl:apply-templates select="TEI:num"/>
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='PS'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text> </xsl:text>
                                                        </span>
                                                        <xsl:for-each select="TEI:num">
                                                            <xsl:value-of select="."/>
                                                            <xsl:if test="following-sibling::TEI:num">
                                                                <xsl:choose>
                                                                    <xsl:when test="following-sibling::TEI:num[position()!=last()]">
                                                                        <xsl:text>, </xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> og </xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='US'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text> </xsl:text>
                                                        </span>
                                                        <xsl:for-each select="TEI:num">
                                                            <xsl:value-of select="."/>
                                                            <xsl:if test="following-sibling::TEI:num">
                                                                <xsl:choose>
                                                                    <xsl:when test="following-sibling::TEI:num[position()!=last()]">
                                                                        <xsl:text>, </xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> og </xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:when test="@xml:id='VU'">
                                                        <span class="desc">
                                                            <xsl:apply-templates select="TEI:desc"/>
                                                            <xsl:text> </xsl:text>
                                                        </span>
                                                        <xsl:for-each select="TEI:num">
                                                            <xsl:value-of select="."/>
                                                            <xsl:if test="following-sibling::TEI:num">
                                                                <xsl:choose>
                                                                    <xsl:when test="following-sibling::TEI:num[position()!=last()]">
                                                                        <xsl:text>, </xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> og </xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <span style="color:red">
                                                            <xsl:text>TEKSTKILDE MANGLER!!!</xsl:text>
                                                        </span>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </xsl:for-each>
                        </tr>
                        
                        <tr>
                            <xsl:if test="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                <xsl:text>Andre udgaver</xsl:text>
                                <xsl:for-each select="//TEI:listWit[@xml:id='pageNumber']/TEI:witness">
                                    <div class="table">
                                        <table class="witList">
                                            <tr>
                                                <td class="sigel">
                                                    <xsl:value-of select="@xml:id"/>
                                                </td>
                                                <td class="source">
                                                    <span class="desc">
                                                        <xsl:apply-templates select="TEI:desc"/>
                                                        <xsl:text> </xsl:text>
                                                    </span>
                                                    <span class="vol">
                                                        <xsl:for-each select="TEI:num">
                                                            <xsl:value-of select="."/>
                                                            <xsl:if test="following-sibling::TEI:num">
                                                                <xsl:choose>
                                                                    <xsl:when test="following-sibling::TEI:num[position()!=last()]">
                                                                        <xsl:text>, </xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> og </xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </xsl:for-each>
                            </xsl:if>
                        </tr>
                    </div>
                    
                    <xsl:variable name="introPath" select="concat('../', substring-before(//TEI:note[@type='intro' or @type='noIntro']/@target,'_intro'),'/',//TEI:note[@type='intro']/@target)"/>
                    
                    <div class="kolofon">                        
                        <xsl:variable name="authorCom">
                            <xsl:choose>
                                <xsl:when test="//TEI:note[@type='minusCom']">
                                    <xsl:text>GV forsyner ikke dette værk med verbalkommentarer</xsl:text>
                                </xsl:when>
                                <xsl:when test="//TEI:note[@type='noCom']">
                                    <xsl:text>under udarbejdelse</xsl:text>
                                </xsl:when>
                                <xsl:when test="//TEI:note[@type='com']">
                                    <xsl:text>skrevet af </xsl:text>
                                    <xsl:for-each select="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                        <xsl:apply-templates/>
                                        <xsl:if test="following-sibling::TEI:author">
                                            <xsl:choose>
                                                <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                                    <xsl:call-template name="delimiterComma"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:text> og </xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        
                        <xsl:variable name="editorCom">
                            <xsl:if test="//TEI:note[@type='com']">
                                <xsl:text>, redigeret af </xsl:text>
                                <xsl:for-each select="document(//TEI:note[@type='com']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor1' or @role='editor3']">
                                    <xsl:apply-templates/>
                                    <xsl:if test="following-sibling::TEI:editor[@role='editor1' or @role='editor3']">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::TEI:editor[@role='editor1' or @role='editor3'][position()!=last()]">
                                                <xsl:call-template name="delimiterComma"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> og </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="authorIntro">
                            <xsl:choose>
                                <xsl:when test="//TEI:note[@type='noIntro']">
                                    <xsl:text>under udarbejdelse</xsl:text>
                                </xsl:when>
                                <xsl:when test="//TEI:note[@type='intro']">
                                    <xsl:text>skrevet af </xsl:text>            
                                    <xsl:for-each select="document($introPath,.)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                        <xsl:apply-templates/>
                                        <xsl:if test="following-sibling::TEI:author">
                                            <xsl:choose>
                                                <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                                    <xsl:call-template name="delimiterComma"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:text> og </xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        
                        <xsl:variable name="editorIntro">
                            <xsl:if test="//TEI:note[@type='intro']">
                                <xsl:text>, redigeret af </xsl:text>
                                <xsl:for-each select="document($introPath,.)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor1' or @role='editor3']">
                                    <xsl:apply-templates/>
                                    <xsl:if test="following-sibling::TEI:editor[@role='editor1' or @role='editor3']">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::TEI:editor[@role='editor1' or @role='editor3'][position()!=last()]">
                                                <xsl:call-template name="delimiterComma"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> og </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="authorTxr">
                            <xsl:choose>
                                <xsl:when test="//TEI:note[@type='noTxr']">
                                    <xsl:text>under udarbejdelse</xsl:text>
                                </xsl:when>
                                <xsl:when test="//TEI:note[@type='txr']">
                                    <xsl:text>skrevet af </xsl:text>
                                    <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                        <xsl:apply-templates/>
                                        <xsl:if test="following-sibling::TEI:author">
                                            <xsl:choose>
                                                <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                                    <xsl:call-template name="delimiterComma"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:text> og </xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>                            
                        </xsl:variable>
                        
                        <xsl:variable name="editorTxr">
                            <xsl:if test="//TEI:note[@type='txr']">
                                <xsl:text>, redigeret af </xsl:text>
                                <xsl:for-each select="document(//TEI:note[@type='txr']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor1' or @role='editor2']">
                                    <xsl:apply-templates select="."/>
                                    <xsl:if test="following-sibling::TEI:editor[@role='editor1' or @role='editor2']">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::TEI:editor[@role='editor1' or @role='editor2'][position()!=last()]">
                                                <xsl:call-template name="delimiterComma"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> og </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:call-template name="philologist"/>
                        
                        <xsl:choose>
                            <!-- 1 A:CIT E:CIT -->                            
                            <xsl:when test="($authorCom=$authorIntro and $authorIntro=$authorTxr) and ($editorCom=$editorIntro and $editorIntro=$editorTxr)">
                                <div>
                                    <xsl:text>Punktkommentarer, indledning og tekstredegørelse er </xsl:text><xsl:value-of select="$authorCom"/><xsl:value-of select="$editorCom"/>
                                </div>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <!-- 2 A:CI E:CI -->
                                    <xsl:when test="$authorCom=$authorIntro and $editorCom=$editorIntro">
                                        <div>
                                            <xsl:text>Punktkommentarer og indledning er </xsl:text><xsl:value-of select="$authorCom"/><xsl:value-of select="$editorCom"/>
                                        </div>
                                        <div>
                                            <xsl:text>Tekstredegørelse er </xsl:text><xsl:value-of select="$authorTxr"/><xsl:value-of select="$editorTxr"/>
                                        </div>
                                    </xsl:when>
                                    <!-- 3 A:CT E:CT -->
                                    <xsl:when test="$authorCom=$authorTxr and $editorCom=$editorTxr">
                                        <div>
                                            <xsl:text>Punktkommentarer og tekstredegørelse er </xsl:text><xsl:value-of select="$authorCom"/><xsl:value-of select="$editorCom"/>
                                        </div>
                                        <div>
                                            <xsl:text>Indledning er </xsl:text><xsl:value-of select="$authorIntro"/><xsl:value-of select="$editorIntro"/>
                                        </div>
                                    </xsl:when>
                                    <!-- 4 A:IT E:IT -->
                                    <xsl:when test="$authorIntro=$authorTxr and $editorIntro=$editorTxr">
                                        <div>
                                            <xsl:choose>
                                                <xsl:when test="//TEI:note[@type='minusCom']">
                                                    <xsl:text>GV forsyner ikke dette værk med verbalkommentarer</xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:text>Punktkommentarer er </xsl:text><xsl:value-of select="$authorCom"/><xsl:value-of select="$editorCom"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <div>
                                            <xsl:text>Indledning og tekstredegørelse er </xsl:text><xsl:value-of select="$authorIntro"/><xsl:value-of select="$editorIntro"/>
                                        </div>
                                    </xsl:when>
                                    <!-- 5 C I T -->
                                    <xsl:otherwise>
                                        <div>
                                            <xsl:text>Punktkommentarer er </xsl:text><xsl:value-of select="$authorCom"/><xsl:value-of select="$editorCom"/>
                                        </div>
                                        <div>
                                            <xsl:text>Indledning er </xsl:text><xsl:value-of select="$authorIntro"/><xsl:value-of select="$editorIntro"/>
                                        </div>
                                        <div>
                                            <xsl:text>Tekstredegørelse er </xsl:text><xsl:value-of select="$authorTxr"/><xsl:value-of select="$editorTxr"/>
                                        </div>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                        <!-- ordlyd kolofon END -->
                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:variable name="contributorCom">
                            <xsl:if test="//TEI:note[@type='com']">
                                <xsl:for-each select="document(//TEI:note[@type='com']/@target,.)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor2']">
                                    <xsl:apply-templates select="."/>
                                    <xsl:if test="following-sibling::TEI:editor[@role='editor2']">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::TEI:editor[@role='editor2'][position()!=last()]">
                                                <xsl:call-template name="delimiterComma"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> og </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="contributorIntro">
                            <xsl:if test="//TEI:note[@type='intro']">
                                <xsl:for-each select="document($introPath,.)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor2']">
                                    <xsl:apply-templates select="."/>
                                    <xsl:if test="following-sibling::TEI:editor[@role='editor2']">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::TEI:editor[@role='editor2'][position()!=last()]">
                                                <xsl:call-template name="delimiterComma"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> og </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="contributorTxr">
                            <xsl:if test="//TEI:note[@type='txr']">
                                <xsl:for-each select="document(//TEI:note[@type='txr']/@target,.)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='contributor']">
                                    <xsl:apply-templates select="."/>
                                    <xsl:if test="following-sibling::TEI:editor[@role='contributor']">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::TEI:editor[@role='contributor'][position()!=last()]">
                                                <xsl:call-template name="delimiterComma"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> og </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:choose>
                            <!-- 1 AAA -->
                            <xsl:when test="($contributorCom=$contributorIntro) and ($contributorIntro=$contributorTxr)">
                                <xsl:if test="$contributorCom!=''">
                                    <div>
                                        <xsl:text>Tilsyn ved punktkommentarer, indledning og tekstredegørelse </xsl:text><xsl:value-of select="$contributorCom"/>
                                    </div>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <!-- 7 AAB -->
                                    <xsl:when test="$contributorCom=$contributorIntro">
                                        <xsl:if test="$contributorCom!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved punktkommentarer og indledning </xsl:text><xsl:value-of select="$contributorCom"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$contributorTxr!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved tekstredegørelse </xsl:text><xsl:value-of select="$contributorTxr"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- 8 ABA -->
                                    <xsl:when test="$contributorCom=$contributorTxr">
                                        <xsl:if test="$contributorCom!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved punktkommentarer og tekstredegørelse </xsl:text><xsl:value-of select="$contributorCom"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$contributorIntro!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved indledning </xsl:text><xsl:value-of select="$contributorIntro"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- 9 ABB -->
                                    <xsl:when test="$contributorIntro=$contributorTxr">
                                        <xsl:if test="$contributorCom!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved punktkommentarer </xsl:text><xsl:value-of select="$contributorCom"/>
                                            </div>                                            
                                        </xsl:if>
                                        <xsl:if test="$contributorIntro!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved indledning og tekstredegørelse </xsl:text><xsl:value-of select="$contributorIntro"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- 13 ABC -->
                                    <xsl:otherwise>
                                        <xsl:if test="$contributorCom!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved punktkommentarer </xsl:text><xsl:value-of select="$contributorCom"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$contributorIntro!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved indledning </xsl:text><xsl:value-of select="$contributorIntro"/>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$contributorTxr!=''">
                                            <div>
                                                <xsl:text>Tilsyn ved tekstredegørelse </xsl:text><xsl:value-of select="$contributorTxr"/>
                                            </div>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>                        
                    </div>
                    
                    <div class="kolofon">
                        <xsl:if test="//TEI:editor[@role='contributor']">
                            <xsl:text>I øvrigt takkes </xsl:text><xsl:value-of select="//TEI:editor[@role='contributor']"/>
                        </xsl:if>
                    </div>
                    
                    <div class="kolofon">
                        <xsl:text>XML ved Kim Steen Ravn</xsl:text>
                    </div>
                    
                    <div class="copyright">
                        <xsl:text>Copyright: </xsl:text><i><xsl:text>Grundtvigs Værker</xsl:text></i>
                    </div>
                    
                    <div class="genreMenu">
                        <xsl:call-template name="genre"/>
                        <xsl:call-template name="topic"/>
                    </div>
                    
                    <!--div class="genreMenu">
                        <xsl:call-template name="pageSetteings"/>                        
                    </div-->
                    
                </div>
                
                <hr/>
                
                <xsl:apply-templates select="TEI:text"/>
                
            </body>
        </html>        
    </xsl:template>
    
    <xsl:template name="dateAddCom">
        <xsl:choose>
            <xsl:when test="//TEI:idno[@type='addCom']">
                <xsl:choose>
                    <xsl:when test="//TEI:idno[@type='addCom']='0.9'">
                        <xsl:text>, marts 2011</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.0'">
                        <xsl:text>, maj 2012</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.1'">
                        <xsl:text>, november 2012</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.2'">
                        <xsl:text>, maj 2013</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.3'">
                        <xsl:text>, oktober 2013</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.4'">
                        <xsl:text>, maj 2014</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.5'">
                        <xsl:text>, oktober 2014</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.6'">
                        <xsl:text>, maj 2015</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.7'">
                        <xsl:text>, november 2015</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.8'">
                        <xsl:text>, april 2016</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.9'">
                        <xsl:text>, november 2016</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.10'">
                        <xsl:text>, maj 2017</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.11'">
                        <xsl:text>, november 2017</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.12'">
                        <xsl:text>, april 2018</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.13'">
                        <xsl:text>, november 2018</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addCom']='1.14'">
                        <xsl:text>, april 2019</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="dateAddIntro">
        <xsl:choose>
            <xsl:when test="//TEI:idno[@type='addIntro']">
                <xsl:choose>
                    <xsl:when test="//TEI:idno[@type='addIntro']='0.9'">
                        <xsl:text>, marts 2011</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.0'">
                        <xsl:text>, maj 2012</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.1'">
                        <xsl:text>, november 2012</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.2'">
                        <xsl:text>, maj 2013</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.3'">
                        <xsl:text>, oktober 2013</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.4'">
                        <xsl:text>, maj 2014</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.5'">
                        <xsl:text>, oktober 2014</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.6'">
                        <xsl:text>, maj 2015</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.7'">
                        <xsl:text>, november 2015</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.8'">
                        <xsl:text>, april 2016</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.9'">
                        <xsl:text>, november 2016</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.10'">
                        <xsl:text>, maj 2017</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.11'">
                        <xsl:text>, november 2017</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.12'">
                        <xsl:text>, april 2018</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.13'">
                        <xsl:text>, november 2018</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addIntro']='1.14'">
                        <xsl:text>, april 2019</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="dateAddTxr">
        <xsl:choose>
            <xsl:when test="//TEI:idno[@type='addTxr']">
                <xsl:choose>
                    <xsl:when test="//TEI:idno[@type='addTxr']='0.9'">
                        <xsl:text>, marts 2011</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.0'">
                        <xsl:text>, maj 2012</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.1'">
                        <xsl:text>, november 2012</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.2'">
                        <xsl:text>, maj 2013</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.3'">
                        <xsl:text>, oktober 2013</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.4'">
                        <xsl:text>, maj 2014</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.5'">
                        <xsl:text>, oktober 2014</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.6'">
                        <xsl:text>, maj 2015</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.7'">
                        <xsl:text>, november 2015</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.8'">
                        <xsl:text>, april 2016</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.9'">
                        <xsl:text>, november 2016</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.10'">
                        <xsl:text>, maj 2017</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.11'">
                        <xsl:text>, november 2017</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.12'">
                        <xsl:text>, april 2018</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.13'">
                        <xsl:text>, november 2018</xsl:text>
                    </xsl:when>
                    <xsl:when test="//TEI:idno[@type='addTxr']='1.14'">
                        <xsl:text>, april 2019</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="author">
        <xsl:choose>
            <xsl:when test="//TEI:titleStmt/TEI:author">
                <xsl:choose>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and not(@prev)]">
                        N.F.S. Grundtvig
                        <i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and @rendition='supp']">
                        N.F.S. Grundtvig
                        [<i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>]
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and (@prev='Anmeldelse af' or @prev='Subskriptionsindbydelse til' )]">
                        N.F.S. Grundtvig
                        <span><xsl:text>[Anmeldelse af] </xsl:text><i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i></span>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and @next and not(@prev)]">
                        N.F.S. Grundtvig
                        <span><i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='main']/@next"/><xsl:text>]</xsl:text></span>
                    </xsl:when>
                    
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and not(@prev)]">
                        N.F.S. Grundtvig
                        &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and @rendition='supp']">
                        N.F.S. Grundtvig
                        &#x201C;[<xsl:apply-templates select="//TEI:title[@rend='part']"/>]&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and @prev='Anmeldelse af']">
                        N.F.S. Grundtvig
                        <span><xsl:text>&#x201C;[Anmeldelse af] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;</span>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and @prev='Subskriptionsindbydelse til']">
                          N.F.S. Grundtvig
                          <span><xsl:text>&#x201C;[Subskriptionsindbydelse til] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;</span>
                     </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and @next and not(@prev)]">
                        N.F.S. Grundtvig
                        <span>&#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='part']/@next"/><xsl:text>]</xsl:text>&#x201D;</span>
                    </xsl:when>
                </xsl:choose>
                <br/>
                <xsl:choose>
                    <xsl:when test="//TEI:title[@rend='shortForm' and not(@prev='Anmeldelse af') and not(@rendition='supp') and not(@next)]">
                        Kortform:&#x2003;&#x2003;&#x2003;
                        <xsl:apply-templates select="//TEI:title[@rend='shortForm']"/>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='shortForm' and @prev='Anmeldelse af' and not(@rendition='supp') and not(@next)]">
                        Kortform:&#x2003;&#x2003;&#x2003;
                        <span><xsl:text>[Anmeldelse af] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='shortForm']"/></span>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='shortForm' and @prev='Anmeldelse af' and not(@rendition='supp') and not(@next)]">
                          Kortform:&#x2003;&#x2003;&#x2003;
                          <span><xsl:text>[Subskriptionsindbydelse til] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='shortForm']"/></span>
                     </xsl:when>
                    <xsl:when test="//TEI:title[@rend='shortForm' and @next and not(@rendition='supp')]">
                        Kortform:&#x2003;&#x2003;&#x2003;
                        <span><xsl:apply-templates select="//TEI:title[@rend='shortForm']"/><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='shortForm']/@next"/><xsl:text>]</xsl:text></span>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='shortForm' and @rendition='supp']">
                        Kortform:&#x2003;&#x2003;&#x2003;
                        [<xsl:apply-templates select="//TEI:title[@rend='shortForm']"/>]
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="addDate">
        <xsl:param name="docType"/>
        <xsl:choose>
            <xsl:when test="//TEI:idno[@type=$docType]='1.0'">
                <xsl:text>, maj 2012</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.1'">
                <xsl:text>, november 2012</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.2'">
                <xsl:text>, maj 2013</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.3'">
                <xsl:text>, oktober 2013</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.4'">
                <xsl:text>, maj 2014</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.5'">
                <xsl:text>, oktober 2014</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.6'">
                <xsl:text>, maj 2015</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.7'">
                <xsl:text>, november 2015</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.8'">
                <xsl:text>, april 2016</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.9'">
                <xsl:text>, november 2016</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.10'">
                <xsl:text>, maj 2017</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.11'">
                <xsl:text>, november 2017</xsl:text>
            </xsl:when>
            <xsl:when test="//TEI:idno[@type=$docType]='1.12'">
                <xsl:text>, april 2018</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="changesContent">
        <div style="margin: 0.5em 0em 0em 0em">
            <xsl:call-template name="changeVersion"/>
        </div>        
    </xsl:template>
    
    <xsl:template name="changeVersion">
        <xsl:choose>
            <xsl:when test="//TEI:idno[@type='changeVersion']">
                <xsl:text>Ændret i version </xsl:text>
                <xsl:for-each select="//TEI:idno[@type='changeVersion']">
                    <xsl:apply-templates/> 
                    <xsl:if test="following-sibling::TEI:idno[@type='changeVersion']">
                        <xsl:choose>
                            <xsl:when test="following-sibling::TEI:idno[@type='changeVersion'][position()!=last()]">
                                <xsl:call-template name="delimiterComma"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> og </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>                
            </xsl:when>
        </xsl:choose>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.0'">
            <xsl:text>, maj 2012</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.1'">
            <xsl:text>, november 2012</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.2'">
            <xsl:text>, maj 2013</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.3'">
            <xsl:text>, oktober 2013</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.4'">
            <xsl:text>, maj 2014</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.5'">
            <xsl:text>, oktober 2014</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.6'">
            <xsl:text>, maj 2015</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.7'">
            <xsl:text>, november 2015</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.8'">
            <xsl:text>, april 2016</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.9'">
            <xsl:text>, november 2016</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.10'">
            <xsl:text>, maj 2017</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.11'">
            <xsl:text>, november 2017</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.12'">
            <xsl:text>, april 2018</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.13'">
            <xsl:text>, november 2018</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.14'">
            <xsl:text>, april 2019</xsl:text>
        </xsl:if>
        <xsl:if test="//TEI:idno[@type='changeVersion'][position()=last()]='1.15'">
            <xsl:text>, november 2019</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="philologist">
        <xsl:text>Teksten er etableret af </xsl:text>
        <xsl:for-each select="//TEI:editor[@role='philologist']">
            <xsl:value-of select="."/>
            <xsl:if test="following-sibling::TEI:editor[@role='philologist']">
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:editor[@role='philologist'][position()!=last()]">
                        <xsl:call-template name="delimiterComma"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> og </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
        <xsl:call-template name="delimiterFullStop"/>
    </xsl:template>
    
    <xsl:template name="editor">
        <xsl:choose>
            <xsl:when test="//TEI:titleStmt/TEI:editor[@xml:id='LCH']">
                L.C. Hagen (udg.)
                <xsl:choose>
                    <xsl:when test="//TEI:title[@rend='main']">
                        <i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part']">
                        &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                </xsl:choose>                
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="genre">        
        <div style="margin: 0em 0em 0em 0em">
            <xsl:text>Genre:</xsl:text>
        </div>
        <xsl:choose>
            <xsl:when test="//TEI:classCode[@scheme='http://grundtvigsværker.dk/genre.xml']">
                <xsl:apply-templates select="//TEI:classCode/TEI:term[position()=1]"/>
                <br/>
                &#x2003;<xsl:apply-templates select="//TEI:classCode/TEI:term[position()=2]"/>
                <br/>
                &#x2003;&#x2003;<xsl:apply-templates select="//TEI:classCode/TEI:term[position()=3]"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="topic">        
        <div style="margin: 1em 0em 0em 0em">
            <xsl:text>Emneord:</xsl:text>
        </div>
        <xsl:choose>
            <xsl:when test="//TEI:keywords[@scheme='http://grundtvigsværker.dk/emneord.xml']/TEI:term">
                <xsl:choose>
                    <xsl:when test="//TEI:keywords/TEI:term[position()=1]">
                        <div>
                            <xsl:value-of select="//TEI:keywords/TEI:term[position()=1]"/>
                        </div>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="//TEI:keywords/TEI:term[position()=2]">
                        <div>
                            &#x2003;<xsl:value-of select="//TEI:keywords/TEI:term[position()=2]"/>
                        </div>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="//TEI:keywords/TEI:term[position()=3]">
                        <div>
                            &#x2003;&#x2003;<xsl:value-of select="//TEI:keywords/TEI:term[position()=3]"/>
                        </div>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="//TEI:keywords/TEI:term[position()=4]">
                        <div>
                            &#x2003;&#x2003;&#x2003;<xsl:value-of select="//TEI:keywords/TEI:term[position()=4]"/>
                        </div>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="//TEI:keywords/TEI:term[position()=5]">
                        <div>
                            &#x2003;&#x2003;&#x2003;&#x2003;<xsl:value-of select="//TEI:keywords/TEI:term[position()=5]"/>
                        </div>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="pageCheckBox">
        <xsl:param name="ed"/>
        <xsl:if test="//TEI:pb[@ed=$ed]">
            <xsl:value-of select="$ed"/>
            <input id="showHidePag{$ed}" type="checkbox" onclick="showhidepageref('{$ed}')"/>
        </xsl:if>    
    </xsl:template>
    
    <xsl:template match="TEI:pb">
        <xsl:choose>
            <xsl:when test="@facs and @type='text' and not(@rend='supp')">
                <a class="pbFax" href="{@facs}" target="_blank" title="Se faksimile" id="{@facs}">
                    <span class="pb{@ed}">
                        <xsl:text>|</xsl:text>
                        <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>          
                    </span>
                </a>
            </xsl:when>
            <xsl:when test="@facs and @type='text' and @rend='supp'">
                <a class="pbFax" href="{@facs}" target="_blank" title="Se faksimile" id="{@facs}">
                    <span class="pb{@ed}">
                        <xsl:text>|</xsl:text>
                        <xsl:text>[</xsl:text>
                        <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
                        <xsl:text>]</xsl:text>
                    </span>
                </a>
            </xsl:when>
            <xsl:when test="@type='edition'">                
                <span class="pb{@ed}">
                    <xsl:text>|</xsl:text>
                    <xsl:value-of select="@ed"/>:<xsl:value-of select="@n"/>
                </span>                
            </xsl:when>
            <xsl:when test="@type='periText'">                
                <span class="pb{@ed}">
                    <xsl:value-of select="concat('', substring-after(@facs,'fax'))"/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="pageSetteings">
        <table>
            <thead>
                <tr>Vis sidetal i:</tr>
            </thead>
            <tr>
                <td class="settingsA">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'A'"/>
                    </xsl:call-template>
                </td>
                <td class="settingsEdition">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'PS'"/>
                    </xsl:call-template>
                </td>
                <td class="settingsEdition">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU1'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU2'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU3'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU4'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU5'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU6'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU7'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU8'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU9'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'VU10'"/>
                    </xsl:call-template>
                </td>
            </tr>
            <tr>
                <td class="settingsEdition">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US1'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US2'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US3'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US4'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US5'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US6'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US7'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US8'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US9'"/>
                    </xsl:call-template>
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'US10'"/>
                    </xsl:call-template>
                </td>
                <td class="settingsEdition">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'Gskv'"/>
                    </xsl:call-template>
                </td>
                <td class="settingsEdition">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'GSV'"/>
                    </xsl:call-template>
                </td>
                <td class="settingsEdition">
                    <xsl:call-template name="pageCheckBox">
                        <xsl:with-param name="ed" select="'Rønning'"/>
                    </xsl:call-template>                    
                </td>
            </tr>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='com']/TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type and @n and @type!='comStart' and @type!='comEnd']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='com']">
                <span class="seg"><xsl:apply-templates/> (<xsl:value-of select="@n"/>)</span>
            </xsl:when>            
            <xsl:otherwise>
                <span class="noSeg">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='comStart' and @n]">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='com']"><span class="seg">&#x25BA;<xsl:apply-templates/></span></xsl:when>
            <xsl:otherwise>
                <span class="noSeg">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:seg[@type='comEnd' and @n]">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='com']"><span class="seg">&#x25C4;<xsl:apply-templates/> (<xsl:value-of select="@n"/>)</span>
            </xsl:when>
            <xsl:otherwise>
                <span class="noSeg">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="delimiterComma">
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    <xsl:template name="delimiterFullStop">
        <xsl:text>.</xsl:text>
    </xsl:template>
    
    <xsl:template match="TEI:front">
        <xsl:choose>
            <xsl:when test="@style='romanType' and @rend">                
                <div style="font-family: sans-serif">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend and not(@style)">
                <div class="typeValue">
                    <xsl:text>&lt;div type="</xsl:text><xsl:value-of select="@rend"/><xsl:text>"&gt;</xsl:text>
                </div>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="not(@rend) and not(@style)">
                <div class="typeValue">
                    <xsl:text>&lt;front&gt; mangler rend-attribut</xsl:text>
                </div>
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:titlePage">
        <xsl:choose>
            <xsl:when test="@type='dustTitlePage'">
                <div class="dustTitlePaget">
                    <br/><br/><br/><br/><br/>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='first'">
                <div class="titlePageFirst">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='second'">
                <div class="titlePageSecond">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:titlePart">
        <xsl:choose>
            <xsl:when test="@type='main'">
                <div class="titlePartMain">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='part'">
                <div class="titlePartPart">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:figure[@type='engraver']">
        <div class="engraver">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div1[@type='illustrator']">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:byline">
        <div class="byline">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docAuthor">
        <div class="docAuthor">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='prof']">
        <div class="noteProf">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:docImprint">        
        <div class="docImprint">
            <xsl:apply-templates/>
        </div>        
    </xsl:template>
    
    <xsl:template match="TEI:docTitle">
        <div class="docTitle">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:pubPlace">
        <xsl:choose>
            <xsl:when test="@rend">
                <div class="{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="pubPlace">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:docDate">
        <xsl:choose>
            <xsl:when test="parent::TEI:pubPlace">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <div class="docDate">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:publisher">        
        <div class="publisher">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:epigraph">
        <div class="epigraph">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div1[@type='motto']">
        <div class="motto">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:body[@style='romanType']">
        <div style="font-family: sans-serif">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:char">
        <xsl:choose>
            <xsl:when test="@rend='space1'">
                &#x2003;
            </xsl:when>
            <xsl:when test="@rend='space2'">
                &#x2003;&#x2003;
            </xsl:when>
            <xsl:when test="@rend='space3'">
                &#x2003;&#x2003;&#x2003;
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='index']/TEI:row">
        <tr class="index">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='index']/TEI:row[not(@rend)]/TEI:cell">        
        <td class="index {@rend}">
            <a class="index" href="#{../@corresp}">
                <xsl:apply-templates/>
            </a>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='index']/TEI:row[@rend='head']/TEI:cell[@cols]">        
        <td style="font-weight: bold; text-align: center" colspan="{@cols}">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='plain']/TEI:row">
        <tr class="plain">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='synopsis']/TEI:row">
        <tr class="synopsis">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='subscription']">
        <table class="subscription">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='subscription']/TEI:row">
        <tr class="subscription">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@type='subscription']//TEI:cell">
        <td class="subscription">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell">
        <xsl:choose>
            <xsl:when test="@corresp">
                <td class="{@rend}">                    
                    <xsl:apply-templates/>                    
                </td>
            </xsl:when>
            <xsl:when test="@cols">
                <td class="{@rend}" colspan="{@cols}">                    
                    <xsl:apply-templates/>                    
                </td>
            </xsl:when>
            <xsl:when test="@n">
                <td>
                    <span class="number">
                        <xsl:value-of select="@n"/>
                        &#x2003;
                    </span>
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="{@rend}">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:figure">
        <xsl:choose>
            <xsl:when test="@type='imageMyth'">
                <div class="imageMyth">
                    <div class="imageMythHead">
                        <xsl:apply-templates select="TEI:head"/>
                    </div>
                    <div>
                        <img src="{TEI:graphic/@url}" alt="Sorry!"/>
                    </div>
                    <div class="imageMythFigDisc">
                        <xsl:apply-templates select="TEI:figDesc"/>
                    </div>
                </div>
            </xsl:when>
            <xsl:when test="@type='asterisk'">
                <div class="asterisk">
                    <xsl:text>&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@type='asterisk2'">
                <div class="asterisk3">
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@type='asterisk3'">
                <div class="asterisk3">
                    <xsl:text>&#x002A;</xsl:text>
                    <br/>
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@type='longLine'">
                <div class="longLine">
                    <hr align="center" width="16%"/>
                </div>
            </xsl:when>
            <xsl:when test="@type='shortLine'">
                <div class="shortLine">
                    <hr align="center" width="8%"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:graphic">
        <xsl:choose>
            <xsl:when test="@style='blank'">
                <br/>
            </xsl:when>
            <xsl:when test="@style='asterisk'">
                <div class="asterisk">
                    <xsl:text>&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@style='asterisk2'">
                <div class="asterisk3">
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@style='asterisk3'">
                <div class="asterisk3">
                    <xsl:text>&#x002A;</xsl:text>
                    <br/>
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@style='asteriskUp'">
                <div class="asteriskUp">
                    <xsl:text>&#x002A;</xsl:text>
                    <br/>
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@style='asteriskDown'">
                <div class="asteriskDown">
                    <xsl:text>&#x002A;&#x2003;&#x002A;</xsl:text>
                    <br/>
                    <xsl:text>&#x002A;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@style='cross'">
                <div class="cross">
                    <xsl:text>&#x271D;</xsl:text>
                </div>
            </xsl:when>
            <xsl:when test="@style='longLine'">
                <div class="longLine">
                    <hr align="center" width="16%"/>
                </div>
            </xsl:when>
            <xsl:when test="@style='shortLine'">
                <div class="shortLine">
                    <hr align="center" width="8%"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:lb">        
        <br>
            <xsl:apply-templates/>
        </br>        
    </xsl:template>
    
    <xsl:template match="TEI:body//TEI:div[not(@subtype)]">
        <div class="typeValue">
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:text>&lt;div type="</xsl:text><xsl:value-of select="@type"/><xsl:text>"&gt;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>&lt;div&gt;-elementet mangler type-attribut</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <div class="chapter">
            <div>
                <xsl:if test="//TEI:note[@type='marginNote']">
                    <xsl:attribute name="class">mainColumn</xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="node()[local-name()!='div']"/>
                <xsl:call-template name="footnote"/>
            </div>
            <xsl:apply-templates select="TEI:div"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='marginNote']">
        <div class="marginNote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template name="footnote">
        <xsl:choose>
            <xsl:when test="*[local-name()!='div']//TEI:note[@type='footnote' and @rendition='noFootLine']">
                <xsl:apply-templates select="*[local-name()!='div']//TEI:note[@type='footnote']" mode="foot"/>
            </xsl:when>
            <xsl:when test="*[local-name()!='div']//TEI:note[@type='footnote' and not(@rendition)]">
                <hr class="footLine"/>
                <xsl:apply-templates select="*[local-name()!='div']//TEI:note[@type='footnote']" mode="foot"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:body"/>
        </xsl:variable>
        <a id="retur{$id}" href="#note{$id}" class="footnote" title="fodnote">
            <xsl:value-of select="$id"/>
        </a>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='footnote']" mode="foot">
        <xsl:variable name="id">
            <xsl:number count="TEI:note[@type='footnote']" level="any" from="TEI:body"/>
        </xsl:variable>
        <a id="note{$id}" href="#retur{$id}" class="footnote" title="fodnote">
            <xsl:value-of select="$id"/>
        </a>               
        <div class="footnote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div">
        <div>
            <xsl:apply-templates/>
        </div>
        <xsl:call-template name="footnote"/>
    </xsl:template>
    
    <xsl:template match="TEI:ref[@type='endNote']">
        <a id="endRetur{@n}" href="#endNote{@n}" class="endNote" title="slutnote">
            <xsl:value-of select="@n"/>
        </a>
    </xsl:template> 
    
    <xsl:template match="TEI:note[@type='endNote']">
        <a id="endNote{@n}" href="#endRetur{@n}" class="endNote" title="slutnote">
            <xsl:value-of select="@n"/>
        </a>
        <div class="endNote">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:lg">
        <table class="lg">            
            <tr valign="top">
                <td class="lgNumber">
                    <xsl:value-of select="@n"/>
                </td>
                <xsl:choose>
                    <xsl:when test="@rend">
                        <td class="{@rend}">
                            <xsl:apply-templates/>
                        </td>
                    </xsl:when>
                    <xsl:when test="not(@rend)">
                        <td class="lg_noIndent">
                            <xsl:apply-templates/>
                        </td>
                    </xsl:when>
                </xsl:choose>
            </tr>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <xsl:choose>
            <xsl:when test="@rend='blank'">
                <br/>
            </xsl:when>
            <xsl:when test="not(@rend) and not(@n)">
                <div class="l_noIndent">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@n and not(@rend)">
                <div style="margin-left: -2em">
                    <span><xsl:value-of select="@n"/>&#x2003;</span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend='refrain' or @rend='interRefrain' or @rend='varRefrain' and @rendition">
                <div class="l_{@rendition}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="l_{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:span[@rend='wordBox']">
        <span class="wordBox">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:span[@rend='wordContainer']">
        <span class="wordContainer">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:span[@rend='top']">
        <span class="top">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:span[@rend='down']">
        <span class="down">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:l/TEI:span[@type]">
        <span style="color: green">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:head"> 
        <xsl:choose>
            <xsl:when test="@rend and not(@rendition) and not(@xml:id)">
                <div class="head{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend and @rendition and not(@xml:id)">
                <div class="head{@rendition} head{@rend}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend and @xml:id">
                <div class="head{@rend}" id="{@xml:id}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:app">
        <xsl:choose>
            <xsl:when test="@select='yes' or @select='disc'">
                <span class="app" href="#">
                    <span style="border: 1px solid black">
                        <xsl:apply-templates select="TEI:lem"/>
                    </span>
                    <span class="appInvisible">
                        <xsl:text>] </xsl:text>
                        <xsl:if test="TEI:lem/@wit!='A' or @wit!='DU'">
                            <span class="wit">
                                <i>
                                    <xsl:value-of select="TEI:lem/@wit"/>
                                    <xsl:text>, </xsl:text>
                                </i>
                            </span>
                        </xsl:if>
                        <xsl:if test="TEI:lem/@wit='DU'">
                            <span class="wit">
                                <i>
                                    <xsl:value-of select="TEI:lem"/>
                                    <xsl:text>D&amp;U</xsl:text>
                                    <xsl:text>, </xsl:text>
                                </i>
                            </span>
                        </xsl:if>
                        <xsl:apply-templates select="TEI:rdg[not(@type)]"/>
                        <xsl:text> </xsl:text>
                        <xsl:if test="*[@type='add']">
                            <xsl:apply-templates select="*[@type='add']"/>
                            <xsl:text> </xsl:text>
                            <i>
                                <xsl:value-of select="TEI:note/@subtype"/>
                            </i>
                        </xsl:if>
                    </span>
                </span>
            </xsl:when>
            <xsl:when test="@select='no'">
                <xsl:value-of select="TEI:rdg"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rdg">
        <xsl:apply-templates/>
        <span class="wit">                
            <xsl:text> </xsl:text>
            <i>
                <xsl:value-of select="@wit"/>
                <xsl:choose>
                    <xsl:when test="following-sibling::TEI:rdg[current()/@type or not(@type)]">
                        <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:when test="following-sibling::TEI:rdg[not(current()/@type) and @type]">
                        <xsl:text>; </xsl:text>
                    </xsl:when>
                </xsl:choose>                                
            </i>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:title/TEI:hi[@rend and @rendition]">        
        <span class="{@rendition}Title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:body[not(@rendition)]//TEI:hi[@rend and not(@rendition)]">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:body[not(@rendition)]//TEI:hi[@rend and @rendition]">
        <xsl:choose>
            <xsl:when test="@rend='italic' and @rendition='plain'">
                <span class="plain">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='plain' and @rendition='italic'">
                <span class="italic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:body[@rendition='noFormat']//TEI:hi[@rend]">
        <xsl:choose>
            <xsl:when test="@rend='italic'">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="{@rend}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:body[@rendition='bold']//TEI:hi[@rend]">
        <xsl:choose>
            <xsl:when test="@rend='bold'">
                <span class="italic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='spaced'">
                <span class="bold">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="{@rend}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:body[@rendition='schwab']//TEI:hi[@rend]">
        <xsl:choose>
            <xsl:when test="@rend='schwab'">
                <span class="italic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='spaced'">
                <span class="bold">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="{@rend}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:body[@rendition='size1']//TEI:hi[@rend]">
        <xsl:choose>
            <xsl:when test="@rend='size1'">
                <span class="italic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='spaced'">
                <span class="bold">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="{@rend}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noBible']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='allusion' and not(@subtype)">                
                <span class="rs_bible" title="allusion til {@key}">
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates/>
                    </a>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <xsl:text>allusion til </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>                
            </xsl:when>
            <xsl:when test="@rend='reference' and not(@subtype)">
                <span class="rs_bible">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <xsl:text>jf. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='eg' and not(@subtype)">
                <span class="rs_bible" title="jf. f.eks. {@key}">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <xsl:text>jf. f.eks. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='normForm' and not(@subtype)">
                <span class="rs_bible" title="{@key}">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='quote' and not(@subtype)">
                <span class="rs_bible" title="{@key}">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quote)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='allusion1787' and not(@subtype)">
                <span class="rs_bible" title="allusion til {@key} (1787)">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <xsl:text>allusion til </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='normForm1787' and not(@subtype)">
                <span class="rs_bible" title="{@key} (1787)">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend='reference1787' and not(@subtype)">
                <span class="rs_bible" title="jf. {@key} (1787)">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <xsl:text>jf. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='eg1787' and not(@subtype)">
                <span class="rs_bible" title="jf. f.eks. {@key} (1787)">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <xsl:text>jf. f.eks. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='quote1787' and not(@subtype)">
                <span class="rs_bible" title="{@key} (1787)">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quote 1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='referenceSeptuaginta' and not(@subtype)">
                <span class="rs_bible" title="{@key} referenceSeptuaginta">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (referenceSeptuaginta)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='quoteSeptuaginta' and not(@subtype)">
                <span class="rs_bible" title="{@key} quoteSeptuaginta">
                    <xsl:apply-templates/>
                </span>
                <span style="text-decoration: underline">
                    <xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quoteSeptuaginta)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='allusion' and @subtype='bibleStart'">
                <span class="rs_bible" title="allusion til {@key}">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <xsl:text>allusion til </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='allusion' and @subtype='bibleEnd'">
                <span class="rs_bible" title="allusion til {@key}">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <xsl:text>allusion til </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='reference' and @subtype='bibleStart'">
                <span class="rs_bible" title="jf. {@key}">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <xsl:text>jf. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>            
            <xsl:when test="@rend='reference' and @subtype='bibleEnd'">
                <span class="rs_bible" title="jf. {@key}">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <xsl:text>jf. </xsl:text><a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='eg' and @subtype='bibleStart'">
                <span class="rs_bible" title="jf. f.eks. {@key}">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <xsl:text>jf. f.eks. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='eg' and @subtype='bibleEnd'">
                <span class="rs_bible" title="jf. f.eks. {@key}">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <xsl:text>jf. f.eks. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>           
            <xsl:when test="@rend='normForm' and @subtype='bibleStart'">
                <span class="rs_bible" title="{@key}">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='normForm' and @subtype='bibleEnd'">
                <span class="rs_bible" title="{@key}">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='quote' and @subtype='bibleStart'">
                <span class="rs_bible" title="{@key}">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quote)</xsl:text>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='quote' and @subtype='bibleEnd'">
                <span class="rs_bible" title="{@key}">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quote)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='allusion1787' and @subtype='bibleStart'">
                <span class="rs_bible" title="allusion til {@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <xsl:text>allusion til </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='allusion1787' and @subtype='bibleEnd'">
                <span class="rs_bible" title="allusion til {@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <xsl:text>allusion til </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='reference1787' and @subtype='bibleStart'">
                <span class="rs_bible" title="jf. {@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <xsl:text>jf. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='reference1787' and @subtype='bibleEnd'">
                <span class="rs_bible" title="jf. {@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <xsl:text>jf. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='eg1787' and @subtype='bibleStart'">
                <span class="rs_bible" title="jf. f.eks. {@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <xsl:text>jf. f.eks. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='eg1787' and @subtype='bibleEnd'">
                <span class="rs_bible" title="jf. f.eks. {@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <xsl:text>jf. f.eks. </xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>            
            <xsl:when test="@rend='quote1787' and @subtype='bibleStart'">
                <span class="rs_bible" title="{@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text> [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                      <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quote 1787)</xsl:text>
                    <xsl:text>] &#x25BA;</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='quote1787' and @subtype='bibleEnd'">
                <span class="rs_bible" title="{@key} (1787)">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quote 1787)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@rend='quoteSeptuaginta' and @subtype='bibleStart'">
                <span class="rs_bible" title="{@key} quoteSeptuaginta">
                    <xsl:apply-templates/>
                    <xsl:apply-templates/><xsl:text>&#x25BA;</xsl:text>
                    <!--xsl:text>&#x25C4; [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quoteSeptuaginta)</xsl:text>
                    <xsl:text>]</xsl:text-->
                </span>
            </xsl:when>
            <xsl:when test="@rend='quoteSeptuaginta' and @subtype='bibleEnd'">
                <span class="rs_bible" title="{@key} quoteSeptuaginta">
                    <xsl:apply-templates/>
                    <xsl:text>&#x25C4; [</xsl:text>
                    <a target="_blank" href="http://old.bibelselskabet.dk/danbib/web/bibelen.htm?{@key}" >
                        <xsl:apply-templates select="@key"/>
                    </a><xsl:text> (quoteSeptuaginta)</xsl:text>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='myth' or @type='mythStart' or @type='mythEnd']">
        <xsl:choose>
            <xsl:when test="//TEI:noteStmt/TEI:note[@type='noMyth']">
                <span class="noMyth">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@type='mythStart'">
                <span class="mythStart">
                    &#x25BA;
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@type='mythEnd'">
                <span class="mythEnd">
                    &#x25C4;
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="rs_myth">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:persName">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noPersName']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="persName">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:placeName">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noPlaceName']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="placeName">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='title']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noTitle']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="rs_title">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend and not(@rend='hangingIndent') and not(@rend='hangingIndentPro')]">        
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend='hangingIndentPro' and not(@n)]">        
        <div class="hangingIndentPro">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend='hangingIndentPro' and @n]">
        <table class="proverb">            
            <tr valign="top">
                <td style="text-indent: -2.5em">
                    <xsl:value-of select="@n"/>
                </td>
                <td>
                    <div style="color: black; font-size: 110%; margin-left: 1.3em; text-indent: -1em"><xsl:apply-templates/></div>
                </td>
            </tr>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:back//TEI:div"> 
        <div class="chapter">
            <xsl:if test="@type">   
                <xsl:attribute name="name">
                    <xsl:for-each select="ancestor::TEI:div">
                        <xsl:text>&#x2003;</xsl:text>
                    </xsl:for-each>
                    <xsl:value-of select="@type"/>
                </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates select="node()[local-name()!='div']"/>
            <xsl:call-template name="footnote"/>
        </div>
        <xsl:apply-templates select="TEI:div"/>
    </xsl:template>
    
    <xsl:template match="TEI:table">        
        <table class="{@xml:id}">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:table[@xml:id='corrigenda']/TEI:row">
        <tr class="corrigenda">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:table[@xml:id='corrigenda']/TEI:row/TEI:cell">
        <xsl:choose>
            <xsl:when test="@rows">
                <td class="{@rend}" rowspan="{@rows}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="@cols">
                <td class="{@rend}" colspan="{@cols}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="corrigenda">
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>