import config
import redis
import json

r = redis.StrictRedis(host=config.REDIS_HOST, port=config.REDIS_PORT, db=config.REDIS_DB)

try:
  expTime=config.ZURBAL_CACHE
except:
  expTime=600

def rGet(key):
  return r.get(key)

def rSet(key,value):
  return r.set(key,value)

def rExpire(key,sec):
  return r.expire(key,sec)

def rDelete(key):
  return r.delete(key)

def rKeys(key):
  return r.keys(key)

def rSetNotUpdateZUR(baldata):
  fresh=baldata['fresh']
  if fresh!=None and len(fresh)>0:
    for addr in fresh:
      rSet("zuswallet:balances:address:"+str(addr),json.dumps( {"bal":baldata['bal'][addr],"error":None}))
      rExpire("zuswallet:balances:address:"+str(addr),expTime)

def rExpireAllBalZUR():
  for addr in rKeys("zuswallet:balances:address:*"):
    rDelete(addr)
