<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>IMP_MilStnDefProd_Set_Migration_ID</fullName>
        <field>Migration_ID__c</field>
        <formula>Name + &apos;:&apos; + $Setup.CustomSettings__c.SF_Instance_Identifier__c</formula>
        <name>IMP_MilStnDefProd_Set_Migration_ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>IMP_MilestnDefnProd_Set_Migration_ID</fullName>
        <actions>
            <name>IMP_MilStnDefProd_Set_Migration_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>IMP_MileStnDefn_Set_Migration_ID</description>
        <formula>ISBLANK(Migration_ID__c) &amp;&amp;  NOT(ISBLANK($Setup.CustomSettings__c.SF_Instance_Identifier__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
