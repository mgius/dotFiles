from dis import dis
from pprint import pprint
__builtins__.dis = dis
__builtins__.pprint = pprint
del dis, pprint
