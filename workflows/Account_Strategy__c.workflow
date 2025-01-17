<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CB_Sls_Notification_to_Account_Team_of_Update_to_Account_Strategy_record</fullName>
        <description>CB_Sls_Notification to Account Team of Update to Account Strategy record</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Advocate_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Digital_Advertising_Analyst_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Email_Marketing_Specialist_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>LMA_Strategist_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Marketing_Strategist_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Reputation_Management_Specialist_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>SEO_Specialist_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Social_Media_Rep_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>noreply@cobaltgroup.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inside_Sales/Account_Strategy_Record_Updated</template>
    </alerts>
    <rules>
        <fullName>CB_Sls_Account_Strat_Change</fullName>
        <actions>
            <name>CB_Sls_Notification_to_Account_Team_of_Update_to_Account_Strategy_record</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account_Strategy__c.LastModifiedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
