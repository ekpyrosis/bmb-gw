from japronto import Application


def generic(request):
    return request.Response(json={"result": "ok"})


app = Application()

app.router.add_route('/', generic)

app.run(port=262, debug=True)
