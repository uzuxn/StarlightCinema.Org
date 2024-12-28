
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .custom-bg {
            background-image: url('https://c4.wallpaperflare.com/wallpaper/654/817/86/sunset-wallpaper-preview.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .overlay {
            background: rgba(0, 0, 0, 0.7);
        }
    </style>
</head>

<body class="custom-bg text-white">
    <!-- Overlay -->
    <div class="overlay min-h-screen">
        <!-- Header -->
        <header class="bg-black bg-opacity-70">
            <div class="container
            mx-auto flex justify-between items-center py-4 px-6">
            <h1 class="text-2xl font-bold text-blue-500">StarLightCinema</h1>
            <nav class="space-x-6">
                <a href="userMovies.jsp" class="text-gray-300 hover:text-white">Back to the Home</a>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main class="py-12">
        <div class="container mx-auto px-6 lg:px-20">
            <!-- Title Section -->
            <div class="text-center mb-12">
                <h2 class="text-4xl font-bold text-blue-400">Get in Touch</h2>
                <p class="text-gray-300 mt-4">We'd love to hear from you! Fill out the form below or reach us directly.</p>
            </div>

            <!-- Contact Form and Info -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                <!-- Form Section -->
                

                <!-- Contact Info Section -->
                <div>
                    <h3 class="text-2xl font-semibold text-blue-400 mb-6">Contact Information</h3>
                    <div class="space-y-6">
                        <div class="flex items-center">
                            <span
                                class="bg-blue-500 text-white w-10 h-10 flex justify-center items-center rounded-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M3 8l7.89 5.26c.64.43 1.46.43 2.1 0L21 8m-9 6v6m0-6V5a2 2 0 011-1.73 2 2 0 012 0A2 2 0 0115 5v7m-6 0v6" />
                                </svg>
                            </span>
                            <div class="ml-4">
                                <h4 class="font-semibold text-gray-300">Email</h4>
                                <p class="text-gray-400">contact@starlightcinema.com</p>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <span
                                class="bg-blue-500 text-white w-10 h-10 flex justify-center items-center rounded-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M3 10h4m6 0h4m-10 6h6M7 4h6a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                                </svg>
                            </span>
                            <div class="ml-4">
                                <h4 class="font-semibold text-gray-300">Phone</h4>
                                <p class="text-gray-400">+94 76 678 4412</p>
                                <p class="text-gray-400">+94 78 481 8897</p>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <span
                                class="bg-blue-500 text-white w-10 h-10 flex justify-center items-center rounded-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M17 9V7a4 4 0 00-8 0v2m12 0h.01M3 9h.01m16 11H5a2 2 0 01-2-2V9m18 11a2 2 0 002-2v-7a2 2 0 00-2-2H5a2 2 0 00-2 2v7a2 2 0 002 2z" />
                                </svg>
                            </span>
                            <div class="ml-4">
                                <h4 class="font-semibold text-gray-300">Location</h4>
                                <p class="text-gray-400">Pitipana, Homagama, Sri Lanka</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-black bg-opacity-70 py-6">
        <div class="container mx-auto text-center">
            <p class="text-gray-400">&copy; 2024 StarLightCinema. All rights reserved.</p>
        </div>
    </footer>
</div>
</body>

</html>

