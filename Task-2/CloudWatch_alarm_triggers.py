import boto3

def create_cpu_alarm(instance_id):
    client = boto3.client('cloudwatch')
    
    # Creating an alarm
    response = client.put_metric_alarm(
        AlarmName='CPU_Usage_Alarm',
        AlarmDescription='Alarm for CPU usage exceeding 80%',
        ActionsEnabled=False,
        AlarmActions=[], 
        MetricName='CPUUtilization',
        Namespace='AWS/EC2',
        Statistic='Average',
        Dimensions=[
            {
                'Name': 'Mobilicis_Server_1',
                'Value': instance_id
            },
        ],
        Period=60,  
        EvaluationPeriods=5,  
        Threshold=80.0,  
        ComparisonOperator='GreaterThanOrEqualToThreshold',
        TreatMissingData='missing',
        AlarmActions=['arn:aws:sns:us-east-2:708988327212:MyTopic']  
    )

    print('Alarm created successfully')

#Defining values 
instance_id = 'i-01b0780d866dafe89'
create_cpu_alarm(instance_id)
