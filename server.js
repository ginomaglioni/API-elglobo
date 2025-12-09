/**
 * server.js
 */

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');
const subirArchivo = require('express-fileupload');
const { manejoErrores } = require('./middlewares/manejoErrores');


const app = express();
const sociosRoutes = require('./routes/socios'); 
const usuariosRoutes = require('./routes/usuarios');
const casillerosRoutes = require('./routes/casilleros');
const vistaCobranzasRoutes = require('./routes/vistaCobranzas');
const actividadesRoutes = require('./routes/actividades');
const cobranzasRoutes = require('./routes/cobranzas');
const cobradoresRoutes = require('./routes/cobradores');
const categoriasRoutes = require('./routes/categorias');
const authRoutes = require('./routes/auth'); // Importa las rutas de autenticación
const { verificarToken } = require('./middlewares/authMiddleware');

app.use(cors());
app.use(bodyParser.json());
app.use(subirArchivo());

// Servir la carpeta Imagenes
//app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use('/api/auth', authRoutes); // Rutas de autenticacion

app.use('/api/socios', verificarToken, sociosRoutes);
app.use('/api/usuarios', verificarToken, usuariosRoutes);
app.use('/api/casilleros', verificarToken, casillerosRoutes);
app.use('/api/actividades', actividadesRoutes);
app.use('/api/cobranzas', verificarToken, cobranzasRoutes);
app.use('/api/cobradores', verificarToken, cobradoresRoutes);
app.use('/api/vistaCobranzas', vistaCobranzasRoutes);
app.use('/api/categorias', verificarToken, categoriasRoutes);
app.use('/api', authRoutes); // Usa las rutas bajo /api

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use('/assets', express.static(path.join(__dirname, 'assets')));

// 💡 RUTA AÑADIDA PARA PRUEBA DE CONEXIÓN DEL FRONTEND
app.get('/api/mensaje', (req, res) => {
    // Esta respuesta es la que tu frontend de React está esperando
    res.json({ 
        mensaje: "¡Conexión API exitosa!",
        status: "ok"
    });
});

app.use(manejoErrores);

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
})