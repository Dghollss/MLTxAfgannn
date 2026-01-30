<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Family Dashboard</title>
<script src="/socket.io/socket.io.js"></script>
<style>
  /* ===== Body & Background ===== */
  body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(180deg, #001a12 0%, #001f18 100%);
    color: #0f0;
    overflow-x: hidden;
  }

  /* ===== Hero Section ===== */
  .hero {
    position: relative;
    height: 200px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: radial-gradient(circle at center, #00ff88 0%, #001a12 80%);
    color: #fff;
    text-align: center;
    box-shadow: inset 0 0 60px #00ff88;
  }
  .hero h1 {
    font-size: 2em;
    margin: 0;
    text-shadow: 0 0 10px #00ff88;
  }
  .hero p {
    font-size: 1em;
    text-shadow: 0 0 5px #00ffa3;
  }

  /* ===== Device Grid ===== */
  #devices {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 15px;
    padding: 20px;
  }
  .device {
    background: rgba(0, 255, 136, 0.05);
    border: 1px solid #00ff88;
    border-radius: 12px;
    padding: 15px;
    text-align: center;
    transition: 0.3s;
    box-shadow: 0 0 15px rgba(0,255,136,0.2);
  }
  .device:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 25px rgba(0,255,136,0.5);
  }

  /* ===== Buttons ===== */
  button {
    padding: 5px 10px;
    margin: 5px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    background: linear-gradient(45deg, #00ff88, #00ffa3);
    color: #001a12;
    font-weight: bold;
    transition: 0.3s;
  }
  button:hover {
    background: linear-gradient(45deg, #00ffa3, #00ff88);
    box-shadow: 0 0 10px #00ff88;
  }

  /* ===== Status Colors ===== */
  .status-online { color: #0f0; }
  .status-offline { color: #f00; }
  .status-locked { color: #ffa500; }

  /* ===== Footer ===== */
  footer {
    text-align: center;
    padding: 15px;
    font-size: 0.9em;
    background: linear-gradient(to top, #001a12, transparent);
    color: #0f0;
  }
</style>
</head>
<body>

  <!-- Hero -->
  <div class="hero">
    <div>
      <h1>Family Control Dashboard</h1>
      <p>Realtime Monitoring & Control Devices Anak</p>
    </div>
  </div>

  <!-- Device Grid -->
  <div id="devices"></div>

  <!-- Footer -->
  <footer>
    Family Control &copy; 2026 - Realtime Monitoring
  </footer>

<script>
  const socket = io();

  socket.on('command', data => {
    console.log('Command received:', data);
    alert(`Device ${data.device_id} command: ${data.command}`);
    loadDevices(); // update status realtime
  });

  async function loadDevices() {
    try {
      const res = await fetch('/api/device?user_id=1'); // ganti user_id sesuai login
      const devices = await res.json();
      const container = document.getElementById('devices');
      container.innerHTML = '';
      devices.forEach(d => {
        const div = document.createElement('div');
        div.className = 'device';
        let statusClass = d.status === 'online' ? 'status-online' : d.status === 'offline' ? 'status-offline' : 'status-locked';
        div.innerHTML = `
          <strong>${d.device_name}</strong> <br>
          Status: <span class="${statusClass}">${d.status}</span> <br>
          <button onclick="sendCommand('${d.device_id}','LOCK')">Lock</button>
          <button onclick="sendCommand('${d.device_id}','UNLOCK')">Unlock</button>
        `;
        container.appendChild(div);
      });
    } catch (err) {
      console.error(err);
    }
  }

  async function sendCommand(device_id, command) {
    try {
      await fetch('/api/control/send', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ device_id, command })
      });
    } catch(err) {
      console.error(err);
    }
  }

  loadDevices();
</script>
</body>
</html>
