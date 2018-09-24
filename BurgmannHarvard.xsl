<?xml version="1.0" encoding="utf-8"?>
<!--List of the external resources that we are referencing-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns:t="http://www.microsoft.com/temp">
  <!--When the bibliography or citation is in your document, it's just HTML-->
  <xsl:output method="html" encoding="us-ascii" />
  <!--Match the root element-->
  <xsl:template match="/">
    <!-- New: structure change here...-->
    <xsl:apply-templates select="*" />
    <xsl:choose>
      <!--Set an optional version number for this style-->
      <xsl:when test="b:version">
        <xsl:text>2018.9.24</xsl:text>
      </xsl:when>
      <!--Defines the name of the style in the References dropdown-->
      <xsl:when test="b:StyleName">
        <xsl:text>Harvard - Burgmann (Saurav Yash Agasti)</xsl:text>
      </xsl:when>

      <xsl:when test="b:XslVersion">
				<xsl:text>2018</xsl:text>
			</xsl:when>
      <!--New: need a StyleNameLocalized-->
      <xsl:when test="b:StyleNameLocalized">
        <xsl:choose>
          <!--You will need a when test for each Lcid you want to support-->
          <xsl:when test="b:StyleNameLocalized/b:Lcid='1033'">
            <xsl:text>Harvard - Burgmann (Saurav Yash Agasti)</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!--Specifies which fields should appear in the Create Source dialog when in a collapsed state (The Show All Bibliography Fieldscheckbox is cleared)-->
  <xsl:template match="b:GetImportantFields[b:SourceType = 'Book']">
    <b:ImportantFields>
      <b:ImportantField>
        <xsl:text>b:Author/b:Author/b:NameList</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Title</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Year</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:City</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Publisher</xsl:text>
      </b:ImportantField>
    </b:ImportantFields>
  </xsl:template>

  <!--Defines the output format for a simple Book (in the Bibliography) with important fields defined-->
  <xsl:template match="b:Source[b:SourceType = 'Book']">
    <!--Count the number of Corporate Authors (can only be 0 or 1-->
    <xsl:variable name="cCorporateAuthors">
      <xsl:value-of select="count(b:Author/b:Author/b:Corporate)" />
    </xsl:variable>
    <xsl:variable name="cAuthors">
      <xsl:value-of select="count(b:Author/b:Author/b:NameList/b:Person)" />
    </xsl:variable>
    <!--Label the paragraph as an Office Bibliography paragraph-->
    <p>
      <xsl:choose>
        <xsl:when test="$cCorporateAuthors!=0">
          <!--When the corporate author exists display the corporate author-->
          <xsl:value-of select="b:Author/b:Author/b:Corporate" />
          <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:variable name="i-author">
          	<xsl:text>1</xsl:text>
          </xsl:variable>
        	<xsl:for-each select="b:Author/b:Author/b:NameList/b:Person">
        		<xsl:value-of select="b:Last" />
        		<xsl:text>, </xsl:text>
        		<xsl:value-of select="substring(b:First,1,1)" />
        		<xsl:text>. </xsl:text>
        		<xsl:if test="b:Middle != 0">
        			<xsl:value-of select="b:Middle" />
        			<xsl:text> </xsl:text>
        		</xsl:if> 
	          <xsl:if test="position() &lt; $cAuthors">
        			<xsl:text> and </xsl:text>
        		</xsl:if> 
        	</xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="b:Year" />
      <xsl:text>, </xsl:text>
      <!-- <xsl:value-of select="$cAuthors=2" /> -->
      <i>
        <xsl:value-of select="b:Title" />
        <xsl:text>, </xsl:text>
      </i>
      <xsl:value-of select="b:Publisher" />
      <xsl:text>, </xsl:text>
      <xsl:value-of select="b:City" />
      <xsl:text>. </xsl:text>
    </p>
  </xsl:template>

  <!-- Internet Source -->
  <xsl:template match="b:GetImportantFields[b:SourceType = 'InternetSite']">
    <b:ImportantFields>
      <b:ImportantField>
        <xsl:text>b:Author/b:Author/b:NameList</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Title</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Year</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:DayAccessed</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:MonthAccessed</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:YearAccessed</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:URL</xsl:text>
      </b:ImportantField>
    </b:ImportantFields>
  </xsl:template>

  <!--Defines the output format for a website-->
  <xsl:template match="b:Source[b:SourceType = 'InternetSite']">
    <!--Count the number of Corporate Authors (can only be 0 or 1-->
    <xsl:variable name="cCorporateAuthors">
      <xsl:value-of select="count(b:Author/b:Author/b:Corporate)" />
    </xsl:variable>

    <!--Label the paragraph as an Office Bibliography paragraph-->
    <p>
      <xsl:choose>
        <xsl:when test="$cCorporateAuthors!=0">
          <!--When the corporate author exists display the corporate author-->
          <xsl:value-of select="b:Author/b:Author/b:Corporate" />
          <xsl:text> </xsl:text>
          <xsl:value-of select="b:Year" />
          <xsl:text>, </xsl:text>
          <i>
            <xsl:value-of select="b:Title" />
          </i>
        </xsl:when>
        <xsl:otherwise>
          <!--When the corporate author does not exist, display the normal author-->
          <xsl:value-of select="b:Author/b:Author/b:NameList/b:Person/b:Last" />
          <xsl:text>, </xsl:text>
          <xsl:value-of select="b:Author/b:Author/b:NameList/b:Person/b:First" />
          <xsl:text> </xsl:text>
          <xsl:value-of select="b:Year" />
          <xsl:text>, </xsl:text>
          <i>
            <xsl:value-of select="b:Title" />
          </i>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>, Viewed On </xsl:text>
      <xsl:value-of select="b:DayAccessed" />
      <xsl:text> </xsl:text>
      <xsl:value-of select="b:MonthAccessed" />
      <xsl:text> </xsl:text>
      <xsl:value-of select="b:YearAccessed" />
      <xsl:text>, &lt;</xsl:text>

      <xsl:value-of select="b:URL" />
      <xsl:text>&gt;. </xsl:text>
    </p>
  </xsl:template>

  <!-- Journal Article Source -->
  <xsl:template match="b:GetImportantFields[b:SourceType = 'JournalArticle']">
    <b:ImportantFields>
      <b:ImportantField>
        <xsl:text>b:Author/b:Author/b:NameList</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Year</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Title</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:JournalName</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Volume</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Issue</xsl:text>
      </b:ImportantField>
      <b:ImportantField>
        <xsl:text>b:Pages</xsl:text>
      </b:ImportantField>
    </b:ImportantFields>
  </xsl:template>

  <!-- Output for bibliography -->
  <xsl:template match="b:Source[b:SourceType = 'JournalArticle']">
    <!--Count the number of Corporate Authors (can only be 0 or 1-->
    <xsl:variable name="cCorporateAuthors">
      <xsl:value-of select="count(b:Author/b:Author/b:Corporate)" />
    </xsl:variable>
    <xsl:variable name="cAuthors">
      <xsl:value-of select="count(b:Author/b:Author/b:NameList/b:Person)" />
    </xsl:variable>
    <!--Label the paragraph as an Office Bibliography paragraph-->
    <p>
      <xsl:choose>
        <xsl:when test="$cCorporateAuthors!=0">
          <!--When the corporate author exists display the corporate author-->
          <xsl:value-of select="b:Author/b:Author/b:Corporate" />
          <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="i-author">
            <xsl:text>1</xsl:text>
          </xsl:variable>
          <xsl:for-each select="b:Author/b:Author/b:NameList/b:Person">
            <xsl:value-of select="b:Last" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="substring(b:First,1,1)" />
            <xsl:text>. </xsl:text>
            <xsl:if test="b:Middle != 0">
              <xsl:value-of select="b:Middle" />
              <xsl:text> </xsl:text>
            </xsl:if> 
            <xsl:if test="position() &lt; $cAuthors">
              <xsl:text> and </xsl:text>
            </xsl:if> 
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="b:Year" />
      <xsl:text>, '</xsl:text>
      <xsl:value-of select="b:Title" />
      <xsl:text>', </xsl:text>
      <i>
        <xsl:value-of select="b:JournalName" />
      </i>
      <xsl:text>, vol. </xsl:text>
      <xsl:value-of select="b:Volume" />
      <xsl:text>, no. </xsl:text>
      <xsl:value-of select="b:Issue" />
      <xsl:text>, pp. </xsl:text>
      <xsl:value-of select="b:Pages" />
      <xsl:text>. </xsl:text>
    </p>
  </xsl:template>


  <!--Defines the output of the entire Bibliography-->
  <xsl:template match="b:Bibliography">
    <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">
      <head>
        <style>

          p.MsoBibliography, li.MsoBibliography, div.MsoBibliography

        </style>
      </head>
      <body>
        <xsl:apply-templates select="*">
          <xsl:sort select="b:Author/b:Author"/>
        </xsl:apply-templates>
      </body>
    </html>
  </xsl:template>

  <!--Defines the output of the Citation for a book-->
  <xsl:template match="b:Citation/b:Source[b:SourceType = 'Book']">
    <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">
      <head></head>
      <body>
        <xsl:variable name="cCorporateAuthors">
          <xsl:value-of select="count(b:Author/b:Author/b:Corporate)" />
        </xsl:variable>
        <!--Defines the output format as (Author, Year-->
        <xsl:text>(</xsl:text>
        <xsl:choose>
          <!--When the corporate author exists display the corporate author-->
          <xsl:when test="$cCorporateAuthors!=0">
            <xsl:value-of select="b:Author/b:Author/b:Corporate" />
          </xsl:when>
          <!--When the corporate author does not exist, display the normal author-->
          <xsl:otherwise>
            <xsl:value-of select="b:Author/b:Author/b:NameList/b:Person/b:Last" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="b:Year" />
        <xsl:text>)</xsl:text>
      </body>
    </html>
  </xsl:template>

  <!--Defines the output of the Citation for a Website-->
  <xsl:template match="b:Citation/b:Source[b:SourceType = 'InternetSite']">
    <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">
      <head></head>
      <body>
        <xsl:variable name="cCorporateAuthors">
          <xsl:value-of select="count(b:Author/b:Author/b:Corporate)" />
        </xsl:variable>
        <!--Defines the output format as (Author, Year-->
        <xsl:text>(</xsl:text>
        <xsl:choose>
          <!--When the corporate author exists display the corporate author-->
          <xsl:when test="$cCorporateAuthors!=0">
            <xsl:value-of select="b:Author/b:Author/b:Corporate" />
          </xsl:when>
          <!--When the corporate author does not exist, display the normal author-->
          <xsl:otherwise>
            <xsl:value-of select="b:Author/b:Author/b:NameList/b:Person/b:Last" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="b:Year" />
        <xsl:text>)</xsl:text>
      </body>
    </html>
  </xsl:template>

  <!--Defines the output of the Citation for a Journal Article-->
  <xsl:template match="b:Citation/b:Source[b:SourceType = 'JournalArticle']">
    <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">
      <head></head>
      <body>
        <xsl:variable name="cCorporateAuthors">
          <xsl:value-of select="count(b:Author/b:Author/b:Corporate)" />
        </xsl:variable>
        <!--Defines the output format as (Author, Year-->
        <xsl:text>(</xsl:text>
        <xsl:choose>
          <!--When the corporate author exists display the corporate author-->
          <xsl:when test="$cCorporateAuthors!=0">
            <xsl:value-of select="b:Author/b:Author/b:Corporate" />
          </xsl:when>
          <!--When the corporate author does not exist, display the normal author-->
          <xsl:otherwise>
            <xsl:value-of select="b:Author/b:Author/b:NameList/b:Person/b:Last" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="b:Year" />
        <xsl:text>)</xsl:text>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="text()" />
</xsl:stylesheet>
