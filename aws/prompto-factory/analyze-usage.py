import sys
import ssl
import pymongo
from pymongo import MongoClient
from pymongo.database import Database

def connectMongo():
    url = "mongodb+srv://admin:" + sys.argv[1] + "@seed.cp8j5.mongodb.net/admin?retryWrites=true&w=majority"
    # print(url)
    return MongoClient(url, ssl_cert_reqs=ssl.CERT_NONE)


def printLastSession(db: Database):
    names = db.list_collection_names()
    if "instances" in names:
        instances = db["instances"]
        find = instances.find({"category": "RecentSession"})
        sort = find.sort("lastOpened.text", pymongo.DESCENDING)
        cursor = sort.limit(1)
        try:
            session = cursor.next()
            print(db.name + ": " + session["lastOpened"]["text"])
        except:
            print(db.name + ": <empty>")
        finally:
            cursor.close()


if __name__ == '__main__':
    mongo = connectMongo()
    try:
        dbs = mongo.list_databases()
        for db in dbs:
            printLastSession(mongo[db["name"]])
    finally:
        mongo.close()