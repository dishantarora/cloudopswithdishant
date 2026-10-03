import boto3
import json

TABLE_NAME = "cloudopswithdishant-tf-locks"
# Primary Key in DynamoDB table format for S3 backend: <bucket>/<key>-md5
LOCK_ID_KEY = "cloudopswithdishant-dev-storage-173166704767-us-east-1-an/lock-demo/state-lock-demo.tfstate-md5"

def get_lock_info(region="us-east-1"):
    dynamodb = boto3.resource('dynamodb', region_name=region)
    table = dynamodb.Table(TABLE_NAME)
    
    response = table.get_item(Key={'LockID': LOCK_ID_KEY})
    
    if 'Item' in response:
        print(" ACTIVE LOCK DETECTED IN DYNAMODB:")
        lock_info = json.loads(response['Item']['Info'])
        print(f"  - Lock ID : {response['Item']['LockID']}")
        print(f"  - Created : {lock_info.get('Created')}")
        print(f"  - User    : {lock_info.get('Who')}")
        print(f"  - Operation: {lock_info.get('Operation')}")
        return response['Item']['LockID']
    else:
        print(" No lock item found in DynamoDB. State is clear.")
        return None

if __name__ == "__main__":
    get_lock_info()
