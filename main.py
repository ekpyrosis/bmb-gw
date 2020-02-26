from japronto import Application


def generic(request):
    return request.Response(text="{\n\"result\": \"ok\"\n}")

app = Application()

app.router.add_route('/', generic)


app.run(debug=True)
