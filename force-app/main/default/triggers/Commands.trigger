trigger Commands on Student__c (after update) {
    List<StudentHistory__c> stuHistory = new List<StudentHistory__c>();
    List<Student__c> stt = Trigger.new;
    
        Student__c stuObject = new Student__c();  
        Schema.SObjectType objType = stuObject.getSObjectType(); 
        Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Student__c.fields.getMap(); 
        
        for(Student__c stu : trigger.new)
        {
            Student__c oldstu = trigger.oldMap.get(stu.Id);

            for (String str : mapFields.keyset()) 
            { 
                 
                    if(stu.get(str) != oldstu.get(str))
                    { 
                        stuHistory.add(new StudentHistory__c(Name=str,oldValue__c=String.valueOf(oldstu.get(str)), newValue__c=String.valueOf(stu.get(str)),recordId__c=String.valueOf(stu.Id))); 
                    } 
            }
        }
    insert stuHistory;
}