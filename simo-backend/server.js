const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { Resend } = require('resend');

const app = express();
app.use(cors());
app.use(express.json());

const SECRET = 'simo_secret_key';
const resend = new Resend('re_8r7n2UR3_3HfgTVNrNNnepJSXhy4mW3e2');

const usuarios = [
    {
        id: 1,
        nombre: 'Juan Reciclador',
        email: 'benavidesb944@gmail.com',
        cedula: '1234567890',
        telefono: '3001234567',
        direccion: 'Calle 10 #20-30, Medellín',
        password: bcrypt.hashSync('123456', 10),
        rol: 'reciclador',
        puntosVerdes: 150,
    },
];

app.post('/api/auth/login', (req, res) => {
    console.log('Login recibido:', req.body);
    const { email, password } = req.body;
    const usuario = usuarios.find(u => u.email === email);
    if (!usuario) return res.status(401).json({ message: 'Usuario no encontrado' });

    const passwordValida = bcrypt.compareSync(password, usuario.password);
    if (!passwordValida) return res.status(401).json({ message: 'Contraseña incorrecta' });

    const token = jwt.sign(
        { id: usuario.id, email: usuario.email, rol: usuario.rol },
        SECRET,
        { expiresIn: '8h' }
    );

    return res.json({
        token,
        usuario: {
            id: usuario.id,
            nombre: usuario.nombre,
            email: usuario.email,
            cedula: usuario.cedula,
            telefono: usuario.telefono,
            direccion: usuario.direccion,
            puntosVerdes: usuario.puntosVerdes,
        },
    });
});

app.post('/api/auth/register', (req, res) => {
    console.log('Register recibido:', req.body);
    const { nombre, cedula, telefono, direccion, email, password } = req.body;

    if (!nombre || !cedula || !telefono || !direccion || !email || !password) {
        return res.status(400).json({ message: 'Todos los campos son obligatorios' });
    }

    const existe = usuarios.find(u => u.email === email);
    if (existe) return res.status(400).json({ message: 'El correo ya está registrado' });

    const nuevoUsuario = {
        id: usuarios.length + 1,
        nombre,
        email,
        cedula,
        telefono,
        direccion,
        password: bcrypt.hashSync(password, 10),
        rol: 'reciclador',
        puntosVerdes: 0,
    };

    usuarios.push(nuevoUsuario);
    return res.status(201).json({ message: 'Usuario creado exitosamente' });
});

app.post('/api/auth/recuperar', async (req, res) => {
    const { email } = req.body;

    if (!email) return res.status(400).json({ message: 'El correo es obligatorio' });

    const usuario = usuarios.find(u => u.email === email);
    if (!usuario) return res.status(404).json({ message: 'No existe una cuenta con ese correo' });

    const token = jwt.sign({ email }, SECRET, { expiresIn: '1h' });
    const enlace = `http://localhost:3000/recuperar/${token}`;

    try {
        await resend.emails.send({
            from: 'onboarding@resend.dev',
            to: email,
            subject: 'Recupera tu contraseña - SIMÖ',
            html: `
        <h2>¡Recupera tu contraseña!</h2>
        <p>Hola ${usuario.nombre},</p>
        <p>Haz clic en el siguiente enlace para cambiar tu contraseña:</p>
        <a href="${enlace}" style="background:#db007f;color:white;padding:12px 24px;border-radius:8px;text-decoration:none;">
          Cambiar contraseña
        </a>
        <p>Este enlace expira en 1 hora.</p>
      `,
        });

        console.log('Correo enviado a', email);
        return res.json({ message: 'Enlace enviado a ' + email });
    } catch (e) {
        console.error('Error Resend:', e);
        return res.status(500).json({ message: 'Error al enviar el correo' });
    }
});

app.post('/api/auth/cambiar-password', (req, res) => {
    const { email, nuevaPassword } = req.body;

    if (!email || !nuevaPassword) return res.status(400).json({ message: 'Datos incompletos' });

    const usuario = usuarios.find(u => u.email === email);
    if (!usuario) return res.status(404).json({ message: 'Usuario no encontrado' });

    usuario.password = bcrypt.hashSync(nuevaPassword, 10);
    return res.json({ message: 'Contraseña actualizada exitosamente' });
});

app.get('/api/usuario/me', (req, res) => {
    const auth = req.headers.authorization;
    if (!auth) return res.status(401).json({ message: 'Sin token' });

    try {
        const token = auth.split(' ')[1];
        const decoded = jwt.verify(token, SECRET);
        const usuario = usuarios.find(u => u.id === decoded.id);
        const { password, ...usuarioSinPassword } = usuario;
        return res.json(usuarioSinPassword);
    } catch (e) {
        return res.status(401).json({ message: 'Token inválido' });
    }
});

app.listen(3000, () => {
    console.log('Servidor SIMÖ corriendo en http://localhost:3000');
});