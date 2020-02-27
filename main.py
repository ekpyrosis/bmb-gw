from japronto import Application
from rethinkdb import RethinkDB

r = RethinkDB()
r.connect("localhost", 28015).repl()


def generic(request):
    # print(request.json)
    r.db("geo").table('location').insert(request.json).run()
    return request.Response(json={"result": "ok"})


app = Application()
app.router.add_route('/', generic)
app.run(port=262, debug=False)
