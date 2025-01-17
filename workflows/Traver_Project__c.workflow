<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DS_Traver_EPC</fullName>
        <description>DS_Traver_EPC</description>
        <protected>false</protected>
        <recipients>
            <field>Previous_EPC_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EPC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>noreply.salesforce@cdk.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Traver_Docs/EPC_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>DS_Traver_ProcessCoach</fullName>
        <description>DS_Traver_ProcessCoach</description>
        <protected>false</protected>
        <recipients>
            <field>Previous_Process_Coach_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Process_Coach__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>noreply.salesforce@cdk.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Traver_Docs/Process_Coach_Change_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>DS_Traver_PartyID</fullName>
        <field>PartyID__c</field>
        <formula>Account__r.PartyID__c</formula>
        <name>DS_Traver_PartyID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>DS_Traver_EML_EPC</fullName>
        <actions>
            <name>DS_Traver_EPC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send email notification to new EPC</description>
        <formula>ISCHANGED(EPC__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>DS_Traver_EML_ProcessCoach</fullName>
        <actions>
            <name>DS_Traver_ProcessCoach</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send email notification to new Process Coach</description>
        <formula>ISCHANGED(Process_Coach__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>DS_Traver_UPD_PartyID</fullName>
        <actions>
            <name>DS_Traver_PartyID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates PartyID on creation of new record</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Traver - Initial Tasks</fullName>
        <actions>
            <name>Order_App_Board</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Upload_CSR</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Welcome_Letter_Traver</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Traver_Initial_Process_Override__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Initial tasks for admin (Task - Welcome email, Upload CSR, Order App Board)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>EPC_Intro_Call_Process</name>
                <type>Task</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Traver - Lets Get Started</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Traver_Project__c.Lets_Get_Started__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Let&apos;s get started trigger for Let&apos;s get started call</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Let_s_Get_Started_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Traver_Project__c.Lets_Get_Started__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Traver - Monthly Tasks</fullName>
        <actions>
            <name>Monthly_Call_Task</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 3 AND 4 AND 5 AND 6)</booleanFilter>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Days_Remaining__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Traver__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Monthly Tasks for EPC.  Triggered from Workflow Trigger field on first Monday of Every Month.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Traver - Monthly Tasks Week 2</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Days_Remaining__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Traver__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Week 2 - Monthly Tasks for EPC.  Triggered from Workflow Trigger field on first Monday of Every Month.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Week_2_BDI_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_2_Call_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_2_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_2_Text_Reminder</name>
                <type>Task</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Traver - Monthly Tasks Week 3</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Days_Remaining__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Traver__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Week 3 - Monthly Tasks for EPC.  Triggered from Workflow Trigger field on first Monday of Every Month.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Week_3_BDI_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_3_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Traver - Monthly Tasks Week 4</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Workflow_Trigger__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Days_Remaining__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Traver__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Week 4 - Monthly Tasks for EPC.  Triggered from Workflow Trigger field on first Monday of Every Month.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Week_4_BDI_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_4_Call_and_Live_Meeting_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_4_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Week_4_Text_Reminder</name>
                <type>Task</type>
            </actions>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Traver - Partial Month - 1 Remaining Mondays</fullName>
        <actions>
            <name>Partial_Month_Start_Week_4_BDI_Email_Reminder</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Partial_Month_Start_Week_4_Call_and_Live_Meeting_Reminder</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Partial_Month_Start_Week_4_Email_Reminder</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Partial_Month_Start_Week_4_Text_Reminder</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Partial_Month_Remaining_Mondays__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Partial_Month_Monday_Start__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.EPC__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Partial Month process start.   1 remaining monday - Week 4 Process will start</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Traver - Partial Month - 2 Remaining Mondays</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Partial_Month_Remaining_Mondays__c</field>
            <operation>equals</operation>
            <value>2</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Partial_Month_Monday_Start__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.EPC__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Partial Month process start.   2 remaining mondays</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Partial_Month_Start_Week_3_BDI_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_3_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Partial_Month_Start_Week_4_BDI_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_4_Call_and_Live_Meeting_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_4_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_4_Text_Reminder</name>
                <type>Task</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Traver - Partial Month - 3 Remaining Mondays</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Traver_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Partial_Month_Remaining_Mondays__c</field>
            <operation>equals</operation>
            <value>3</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Partial_Month_Monday_Start__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.EPC__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Traver_Project__c.Project_Start_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Partial Month process start.   3 remaining mondays</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Partial_Month_Start_Week_4_BDI_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_4_Call_and_Live_Meeting_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_4_Email_Reminder</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_4_Text_Reminder</name>
                <type>Task</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Partial_Month_Start_Week_2_BDI_Email</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_2_Call</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_2_Email</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_2_Text</name>
                <type>Task</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Partial_Month_Start_Week_3_BDI_Email</name>
                <type>Task</type>
            </actions>
            <actions>
                <name>Partial_Month_Start_Week_3_Email</name>
                <type>Task</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>EPC_Intro_Call_Process</fullName>
        <assignedToType>owner</assignedToType>
        <description>EPC Intro Call. To be completed within 24 hours</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>EPC Intro Call &amp; Process</subject>
    </tasks>
    <tasks>
        <fullName>Let_s_Get_Started_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>Traver - Lets Get Started Call.</description>
        <dueDateOffset>-2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Lets_Get_Started__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Let&apos;s Get Started Call</subject>
    </tasks>
    <tasks>
        <fullName>Monthly_Call_Task</fullName>
        <assignedToType>owner</assignedToType>
        <description>Monthly EPC call to client.   Log notes and close case when completed.</description>
        <dueDateOffset>20</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Monthly - Call Task</subject>
    </tasks>
    <tasks>
        <fullName>Order_App_Board</fullName>
        <assignedTo>deborah.monroe2@cdk.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Order App Board and Input Tracking number in Task field - Traver - APPT Board Tracking Number.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Order App Board</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_2_BDI_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 2 BDI Email reminder.</description>
        <dueDateOffset>4</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 2 BDI Email</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_2_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 2 Call Reminder.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 2 Call</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_2_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 2 Email reminder.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 2 Email</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_2_Text</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 2 Text Reminder.   Close Task when completed.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 2 Text</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_3_BDI_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 3 BDI Email Reminder.    Attach email and close task when completed</description>
        <dueDateOffset>11</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 3 BDI Email</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_3_BDI_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 3 BDI Email Reminder.   Attach email and close task</description>
        <dueDateOffset>4</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 3 BDI Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_3_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 3 Email Reminder.   Attach email to project and close task.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 3 Email</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_3_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 3 Email Reminder.   Attach email and close task</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 3 Email</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_4_BDI_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - BDI Email Reminder.   Attach email in project and close task.</description>
        <dueDateOffset>18</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 4 BDI Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_4_Call_and_Live_Meeting_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 4 Call and Live Meeting Reminder.   Log Notes in Task and close.</description>
        <dueDateOffset>16</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 4 Call and Live Meeting Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_4_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 4 Email reminder.   Attach email to project and close task.</description>
        <dueDateOffset>15</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 4 Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Partial_Month_Start_Week_4_Text_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Partial Month Start - Week 4 Text Reminder.    Log in task can close</description>
        <dueDateOffset>14</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Partial Month Start - Week 4 - Text Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Upload_CSR</fullName>
        <assignedTo>deborah.monroe2@cdk.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Upload CSR.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Upload CSR</subject>
    </tasks>
    <tasks>
        <fullName>Week_1_BOU_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Email out of BOU.   Once done close task</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 1 - BOU Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_1_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 1 - Email Due.   Please close task once email is sent and attached in Project.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 1 - Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_BDI_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - BDI Email Reminder.    Attach sent email to Project and close task.</description>
        <dueDateOffset>8</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - BDI Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_BDI_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - BDI Email Reminder.    Attach email to project and close task when completed.</description>
        <dueDateOffset>9</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - BDI Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - Call Reminder.   Log Call notes in task and close task when completed.</description>
        <dueDateOffset>8</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - Call</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_Call_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - Call Reminder.   Log call notes and close task when completed.</description>
        <dueDateOffset>9</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - Call Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - Email Reminder.   Attach email in Project and close task.</description>
        <dueDateOffset>8</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - Email Reminder.    Attach email to project and close task when completed.</description>
        <dueDateOffset>8</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_Text</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - Text Reminder - Close case once completed.</description>
        <dueDateOffset>8</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - Text</subject>
    </tasks>
    <tasks>
        <fullName>Week_2_Text_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 2 - Text Reminder.    Log notes in Task and close when completed.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 2 - Text Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_3_BDI_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 3 - BDI Email Reminder.    Attach email in Project and close task once completed.</description>
        <dueDateOffset>15</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 3 - BDI Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_3_BDI_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 3 - BDI Email Reminder.   Attach email to project and close task when completed.</description>
        <dueDateOffset>14</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 3 - BDI Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_3_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 3 - Email Reminder.   Attach Email to Project and close task once completed.</description>
        <dueDateOffset>15</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 3 - Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_3_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 3 - Email Reminder.   Attach email to project and close task when completed.</description>
        <dueDateOffset>14</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 3 - Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_BDI_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - BDI Email Reminder - Attach email to project and close task once completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - BDI Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_BDI_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - BDI Email Reminder.    Attach email to Project and close task when completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - BDI Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_Call_and_Live_Meeting</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - Call AND Live Meeting Reminder.    Log Notes regarding call in task and close once completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - Call and Live Meeting</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_Call_and_Live_Meeting_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - Call AND Live Meeting Reminder.   Log notes in task and close when completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - Call and Live Meeting Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_Email</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - Email Reminder.    Attach email to Project and close task once completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - Email</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_Email_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - Email Reminder.   Attach email to project and close task when completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - Email Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_Text</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - Text Reminder.    Log text notes and close task once completed.</description>
        <dueDateOffset>22</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - Text</subject>
    </tasks>
    <tasks>
        <fullName>Week_4_Text_Reminder</fullName>
        <assignedToType>owner</assignedToType>
        <description>Week 4 - Text Reminder.   Log notes in Task and close when completed.</description>
        <dueDateOffset>21</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Traver_Project__c.Workflow_Trigger__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Week 4 - Text Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Letter_Traver</fullName>
        <assignedTo>kernita.butler@cdk.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Send Welcome Letter</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Welcome Letter - Traver</subject>
    </tasks>
</Workflow>
