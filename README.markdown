# Kill-Bit

Kill-Bit is server and client application that companies can use to remotely wipe data from stolen Laptops. Since we don't trust any remote data wipe services, we rolled our own.

Kill-Bit works by phoning home to a server periodically to see if it should start destroying data.

## Know What You're Doing

Before you use Kill-Bit, make sure you understand how everything works. Its highly recommended that you use an HTTPS certificate with Kill-Bit to prevent man-in-the-middle attacks that could inadvertently destroy your data. There's a lot of things that could go wrong with this, so make sure you're aware of the risks of using Kill-Bit.