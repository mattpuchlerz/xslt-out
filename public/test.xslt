<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ACControl="urn:This:Control" xmlns:ACXslt="urn:ActiveCampus:XSLTLibrary" exclude-result-prefixes="ACControl ACXslt">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:for-each select="ChannelRuleFilters/ChannelRuleFilter">
            <xsl:variable name="ChannelFullPath" select="Channel/property[@name = 'FullPath']" />
            <xsl:for-each select="ChannelItems/ChannelItem">        
                <xsl:variable name="ChannelItemID" select="property[@name='ChannelItemID']" />
                <xsl:choose>
                    
                    <!-- Definition: Spotlight - Alumni -->
                    <xsl:when test="ExtendedObject/ExtendedObjectVersion/Definition/properties/property[@name= 'Name'] = 'Spotlight - Alumni'" >
                        <div class="AC-Block AC-Spot Alumni">
                            <div class="AC-BlockHeader">
                                <h4>Alumni Spotlight</h4>
                            </div>								
                            <div class="AC-BlockText">
                                <div class="AC-BlockTitle">
                                    <strong>
                                        <xsl:value-of select="concat( ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue, ' ', ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue, ' &#8216;', substring(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Class Year']/attributevalues/attributevalue, 3) )" />
                                    </strong>
                                    <br /><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Major']/attributevalues/attributevalue" />
                                </div>
                                <p>
                                    <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Teaser']/attributevalues/attributevalue" />
                                </p>
                            </div>
                            <div class="AC-BlockCtrl">
                                <a>
                                    <xsl:attribute name="href"><xsl:value-of select="ACControl:GetChannelDocumentURL($ChannelFullPath,$ChannelItemID)" /></xsl:attribute>
                                    Read More
                                </a>
                            </div>
                            <div class="AC-BlockImage">
                                <img>
                                    <xsl:variable name="imageOrThumbnail">
                                        <xsl:choose>
                                            <xsl:when test="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue != ''">Thumbnail</xsl:when>
                                            <xsl:otherwise>Image</xsl:otherwise>
                                        </xsl:choose>                                           
                                    </xsl:variable>
                                    <xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = $imageOrThumbnail]/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = $imageOrThumbnail]/attributevalues/attributevalue/properties/property[@name = 'Name']"/>?Thumbnail=true&amp;Width=185&amp;Height=300&amp;RotateFlipType=RotateNoneFlipNone</xsl:attribute>
                                    <xsl:attribute name="alt">Photo of <xsl:value-of select="concat( ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue, ' ', ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue )" /></xsl:attribute>
                                </img>
                            </div>
                        </div>						            
                    </xsl:when>
                    
                    <!-- Definition: Spotlight - Athletic -->
                    <xsl:when test="ExtendedObject/ExtendedObjectVersion/Definition/properties/property[@name= 'Name'] = 'Spotlight - Athletic'" >
                        <div class="AC-Block AC-Spot Athletic">
                            <div class="AC-BlockCt">
                                <div class="AC-BlockHeader">
                                    <h4>Athletic Spotlight</h4>
                                </div>
                                <div class="AC-BlockImage">
                                    <img>
                                        <xsl:choose>
                                            <xsl:when test="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue != ''"><xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'Name']"/></xsl:attribute></xsl:when>
                                            <xsl:otherwise><xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Image']/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'Name']"/></xsl:attribute></xsl:otherwise>
                                        </xsl:choose>											
                                        <xsl:attribute name="alt">Photo Of <xsl:value-of select="concat(concat(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue,' '),ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue)" /></xsl:attribute>
                                    </img>
                                </div>
                                <div class="AC-BlockText">
                                    <p>
                                        <strong><xsl:value-of select="concat(concat(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue,' '),ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue)" /></strong>
                                        <br />
                                        <strong>Major: </strong><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Major']/attributevalues/attributevalue" /><br />
                                        <strong>Sport: </strong><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Sport']/attributevalues/attributevalue" /><br />
                                    </p>
                                    <p>
                                        <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Teaser']/attributevalues/attributevalue" />
                                    </p>
                                </div>
                            </div>
                            <div class="AC-BlockCtrl">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="ACControl:GetChannelDocumentURL($ChannelFullPath,$ChannelItemID)" />
                                    </xsl:attribute>
                                    Read More
                                </a>
                            </div>
                        </div>
                    </xsl:when>
                    
                    <!-- Definition: Spotlight - Faculty -->
                    <xsl:when test="ExtendedObject/ExtendedObjectVersion/Definition/properties/property[@name= 'Name'] = 'Spotlight - Faculty'" >
                        <div class="AC-Block AC-Spot Faculty">
                            <div class="AC-BlockHeader">
                                <h4>Faces &amp; Places</h4>
                            </div>
                            <div class="AC-BlockText">
                                <div class="AC-BlockTitle">
                                    <strong>
                                        <xsl:value-of select="concat( ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue, ' ', ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue )" />
                                    </strong>
                                    <br /><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Department']/attributevalues/attributevalue" />
                                </div>
                                <p>
                                    <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Teaser']/attributevalues/attributevalue" />
                                </p>
                            </div>
                            <div class="AC-BlockCtrl">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="ACControl:GetChannelDocumentURL($ChannelFullPath,$ChannelItemID)" />
                                    </xsl:attribute>
                                    Read More
                                </a>
                            </div>
                            <div class="AC-BlockImage">
                                <img>
                                    <xsl:variable name="imageOrThumbnail">
                                        <xsl:choose>
                                            <xsl:when test="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue != ''">Thumbnail</xsl:when>
                                            <xsl:otherwise>Image</xsl:otherwise>
                                        </xsl:choose>                                           
                                    </xsl:variable>
                                    <xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = $imageOrThumbnail]/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = $imageOrThumbnail]/attributevalues/attributevalue/properties/property[@name = 'Name']"/>?Thumbnail=true&amp;Width=185&amp;Height=300&amp;RotateFlipType=RotateNoneFlipNone</xsl:attribute>
                                    <xsl:attribute name="alt">Photo of <xsl:value-of select="concat( ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue, ' ', ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue )" /></xsl:attribute>
                                </img>
                            </div>
                        </div>
                    </xsl:when>
                    
                    <!-- Definition: Spotlight - Location -->
                    <xsl:when test="ExtendedObject/ExtendedObjectVersion/Definition/properties/property[@name= 'Name'] = 'Spotlight - Location'" >
                        <div class="AC-Block AC-Spot Location">
                            <div class="AC-BlockCt">
                                <div class="AC-BlockHeader">
                                    <h4>Location Spotlight</h4>
                                </div>
                                <div class="AC-BlockImage">
                                    <img>
                                        <xsl:choose>
                                            <xsl:when test="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue != ''"><xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'Name']"/></xsl:attribute></xsl:when>
                                            <xsl:otherwise><xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Image']/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'Name']"/></xsl:attribute></xsl:otherwise>
                                        </xsl:choose>											
                                        <xsl:attribute name="alt">Photo Of <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Title']/attributevalues/attributevalue" /></xsl:attribute>
                                    </img>
                                </div>
                                <div class="AC-BlockText">
                                    <p>
                                        <strong><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Title']/attributevalues/attributevalue" /></strong>
                                        <br />
                                        <strong>Year Built: </strong><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Year Built']/attributevalues/attributevalue" /><br />
                                    </p>
                                    <p>
                                        <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Teaser']/attributevalues/attributevalue" />
                                    </p>
                                </div>
                            </div>
                            <div class="AC-BlockCtrl">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="ACControl:GetChannelDocumentURL($ChannelFullPath,$ChannelItemID)" />
                                    </xsl:attribute>
                                    Read More
                                </a>
                            </div>
                        </div>
                    </xsl:when>
                    
                    <!-- Definition: Spotlight - Program -->
                    <xsl:when test="ExtendedObject/ExtendedObjectVersion/Definition/properties/property[@name= 'Name'] = 'Spotlight - Program'" >
                        <div class="AC-Block AC-Spot Program">
                            <div class="AC-BlockCt">
                                <div class="AC-BlockHeader">
                                    <h4>Program Spotlight</h4>
                                </div>
                                <div class="AC-BlockImage">
                                    <img>
                                        <xsl:choose>
                                            <xsl:when test="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue != ''"><xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'Name']"/></xsl:attribute></xsl:when>
                                            <xsl:otherwise><xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Image']/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue/properties/property[@name = 'Name']"/></xsl:attribute></xsl:otherwise>
                                        </xsl:choose>											
                                        <xsl:attribute name="alt">Photo Of <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Title']/attributevalues/attributevalue" /></xsl:attribute>
                                    </img>
                                </div>
                                <div class="AC-BlockText">
                                    <p>
                                        <strong><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Title']/attributevalues/attributevalue" /></strong>
                                        <br />
                                        <strong>Department: </strong><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Department']/attributevalues/attributevalue" /><br />
                                    </p>
                                    <p>
                                        <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Teaser']/attributevalues/attributevalue" />
                                    </p>
                                </div>
                            </div>
                            <div class="AC-BlockCtrl">
                                <a>
                                    <xsl:attribute name="href"><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Program Page Link']/attributevalues/attributevalue" /></xsl:attribute>
                                    Read More
                                </a>
                            </div>
                        </div>						
                    </xsl:when>
                    
                    <!-- Definition: Spotlight - Student -->
                    <xsl:when test="ExtendedObject/ExtendedObjectVersion/Definition/properties/property[@name= 'Name'] = 'Spotlight - Student'" >
                        <div class="AC-Block AC-Spot Student">
                            <div class="AC-BlockHeader">
                                <h4>Faces &amp; Places</h4>
                            </div>
                            <div class="AC-BlockText">
                                <div class="AC-BlockTitle">
                                    <strong>
                                        <xsl:value-of select="concat( ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue, ' ', ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue, ' &#8216;', substring(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Class Year']/attributevalues/attributevalue, 3) )" />
                                    </strong>
                                    <br /><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Major']/attributevalues/attributevalue" />
                                    <br /><xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Hometown']/attributevalues/attributevalue" />
                                </div>
                                <p>
                                    <xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Teaser']/attributevalues/attributevalue" />
                                </p>
                            </div>
                            <div class="AC-BlockCtrl">
                                <a>
                                    <xsl:attribute name="href"><xsl:value-of select="ACControl:GetChannelDocumentURL($ChannelFullPath,$ChannelItemID)" /></xsl:attribute>
                                    Read More
                                </a>
                            </div>
                            <div class="AC-BlockImage">
                                <img>
                                    <xsl:variable name="imageOrThumbnail">
                                        <xsl:choose>
                                            <xsl:when test="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Thumbnail']/attributevalues/attributevalue != ''">Thumbnail</xsl:when>
                                            <xsl:otherwise>Image</xsl:otherwise>
                                        </xsl:choose>                                           
                                    </xsl:variable>
                                    <xsl:attribute name="src"><xsl:value-of select="ACXslt:MapBinaryFile(ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = $imageOrThumbnail]/attributevalues/attributevalue/properties/property[@name = 'BinaryFileID'])"/>/<xsl:value-of select="ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = $imageOrThumbnail]/attributevalues/attributevalue/properties/property[@name = 'Name']"/>?Thumbnail=true&amp;Width=185&amp;Height=300&amp;RotateFlipType=RotateNoneFlipNone</xsl:attribute>
                                    <xsl:attribute name="alt">Photo of <xsl:value-of select="concat( ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'First Name']/attributevalues/attributevalue, ' ', ExtendedObject/ExtendedObjectVersion/attributes/attribute[@name = 'Last Name']/attributevalues/attributevalue )" /></xsl:attribute>
                                </img>
                            </div>
                        </div>			
                    </xsl:when>
                    
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="flashVideo">
        <xsl:param name="videoUrl" />
        <xsl:param name="xmlUrl" />
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="220" height="185" id="videoSpotlight" align="middle">
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="allowFullScreen" value="false" />
            <param name="movie" value="/Media/Website%20Resources/flash/videoPlayer.swf" />
            <param name="FlashVars">
                <xsl:attribute name="value">
                    <xsl:text>videoUrl=</xsl:text>
                    <xsl:value-of select="$videoUrl"/>
                    <xsl:text disable-output-escaping="no">&amp;xmlUrl=</xsl:text>
                    <xsl:value-of select="$xmlUrl" />
                </xsl:attribute>
            </param>
            <param name="quality" value="high" />
            <param name="bgcolor" value="#ffffff" />
            <param name="scale" value="noscale" />
            <param name="salign" value="lt" />
            <embed src="/Media/Website%20Resources/flash/videoPlayer.swf" width="220" height="185" align="middle" quality="high" bgcolor="#ffffff" scale="noscale" salign="lt" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                <xsl:attribute name="FlashVars">
                    <xsl:text>videoUrl=</xsl:text>
                    <xsl:value-of select="$videoUrl"/>
                    <xsl:text disable-output-escaping="yes">&amp;xmlUrl=</xsl:text>
                    <xsl:value-of select="$xmlUrl" />
                </xsl:attribute>
            </embed>
        </object>
    </xsl:template>
    
</xsl:stylesheet>