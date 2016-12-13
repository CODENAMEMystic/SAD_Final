<?php

class DbConnect
{
    private $conn;
 
    function __construct()
    {
    }
 
    /**
     * Establishing database connection
     * @return database connection handler
     */
    function connect()
    {
        require_once 'Config.php';
 
        // Connecting to mysql database
        $this->conn = new mysqli(107.180.109.20, RockhurstUSER, hawklet, Cuppit);
 
        // Check for database connection error
        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }
 
        // returing connection resource
        return $this->conn;
    }
}
