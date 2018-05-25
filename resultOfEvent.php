<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<meta charset="UTF-8">
	<style type="text/css">
		div {
			
		}
		
		ul {
			list-style: none;
		}
		#text{
			background-color: white;
			width: 950px;
			height: 781px;
			position: relative;
			background-position: -20px;
			margin-left: 50px;
			padding-top: 30px;
		}
		
		
		#header-s {
			height: 100px;
			margin-left: 50px;
		}
		
		#header-x {
			width: 100%;
			background-color: white;
			/*height: 40px;*/
		}
		
		#header-list {
			position: relative;
			width: 1180px;
			margin: auto;
			color: white;
			font-size: 15px;
			line-height: 40px;
			height: 40px;
			/*border: 1px black solid;*/
		}
		
		#header-list>li {
			color: black;
			text-align: center;
			height: 40px;
			list-style: none;
			float: left;
			width: 130px;
			border-right: 1px solid black;
		}
		
		#header-list>li:last-child {
			border-right: none;
		}
		
		#header-list>li>a {
			text-decoration: none;
			color: black;
			border-bottom: 1px solid white;
		}
		
		#header-list>li:hover .out {
			color: deepskyblue;
		}
		
		#header-list>li>ul>li:hover a {
			color: deepskyblue;
		}
		
		.menu-panel {
			position: absolute;
			padding: 0;
			display: none;
			/*z-index: 999;*/
		}
		
		.menu-panel>li {
			background-color: white;
			border: 1px solid grey;
			font-size: 100%;
			margin-top: 1px;
			width: auto;
			height: auto;
			list-style: none;
		}
		
		.menu-panel>li>a {
			text-decoration: none;
			color: black;
			margin: 5px;
			line-height: 40px;
		}
		
		.menu-panel>li:hover a {
			color: black;
		}
		
		#header-list>li:hover .menu-panel {
			display: block;
			z-index: 999;
		}
		
		#header-list>li>a.wu {
			border-bottom: none;
		}
		
		#header-list>li>span {
			position: relative;
			top: 2px;
			margin-left: 5px;
			display: inline-block;
			transform: rotate(180deg);
			color: black;
		}
	</style>
</head>

<body>
	<div>
		<div id="header-s">
			<h3 id="head">INFS7901 - Olympic project</h3>
			<img src="img/jeux-olympiques-pyeongchang-2018-001-620x348.jpg" width="100px" height="50px" />

		</div>
		<div id="header-x">
			<ul id="header-list">
				<li>
					<a class="out" href="ER.html" class="wu">ER diagram</a>
				</li>
				<li>
					<a class="out" href="#">Visitor</a><span>▲</span>
					<ul class="menu-panel">
						
						<li>
							<a href="time.php">Timetable of events</a>
						</li>
						<li>
							<a href="resultOfEvent.php">Results of event</a>
						</li>
						<li>
							<a href="medals.php">Number of medals</a>
						</li>
					</ul>
				</li>
				<li>
					<a class="out" href="#">Athlete</a><span>▲</span>
					<ul class="menu-panel">
						<li>
							<a href="updateAthlete.php">Update personal information</a>
						</li>
						<li>
							<a href="athleteEvent.php">Information of events</a>
						</li>
						<li>
							<a href="athleteResult.php">results of events</a>
						</li>
						<li>
							<a href="athleteTeam.php">Information of team</a>
						</li>
					</ul>
				</li>
				<li>
					<a class="out" href="#">Staff</a><span>▲</span>
					<ul class="menu-panel">
						<li>
							<a href="updateStaff.php">Update personal information</a>
						</li>
						<li>
							<a href="informationOfTeam.php">Information of athletes</a>
						</li>
					</ul>
				</li>
				<li>
					<a class="out" href="#">Coordinator</a><span>▲</span>
					<ul class="menu-panel">
						<li>
							<a href="updateCoordinator.php">Update personal information</a>
						</li>
						<li>
							<a href="informationOfEvent.php">Information of all events</a>
						</li>
						<li>
							<a href="updateEvent.php">Arrange Event</a>
						</li>
					</ul>
				</li>
				<li>
					<a class="out" href="#">Referee</a><span>▲</span>
					<ul class="menu-panel">
						<li>
							<a href="UpdateReferee.php">Update personal information</a>
						</li>
						<li>
							<a href="refereeEvent.php">Information of events</a>
						</li>
						<li>
							<a href="refereeAthlete.php">Information of athletes</a>
						</li>
						<li>
							<a href="UpdateResults.php">Update results</a>
						</li>
					</ul>
				</li>
				<li>
					<a class="out" href="dup.html" class="wu">Home</a>
				</li>
			</ul>
		</div>
		<div id="text">
			<?php 
        		// SETUP PHP CONNECTION
        		$servername = "s4473202.zones.eait.uq.edu.au";
        		$username = "root";
        		$password = "c01284ba3e13810f";
        		$dbname = "olympic";
        
        		$conn = new mysqli($servername, $username, $password, $dbname);
        
        		if ($conn->connect_error) {
            		die("<h3>Connection failed: ".$conn->connect_error."</h3>");
        		}
    		?>
    		<table class="table table-dark">
        		<thead>
            		<tr>
                		<th scope="col">EventCode</th>
                		<th scope="col">EventName</th>
            		</tr>
        		</thead>
        		<tbody id="studentTable">
            		<?php
                		// FILL TABLE WITH DATA ON CLICK
               
                    		// get all our student data
                    		$query = "SELECT EventCode, EventName FROM Event" ;
                    		$result = mysqli_query($conn, $query);
                    		// put all our results into a html table
                    		while ($rows = mysqli_fetch_array($result)) {
                        		echo "<tr>";
                        		echo "<td>".$rows["EventCode"]."</td>";
                        		echo "<td>".$rows["EventName"]."</td>";
                        		echo "</tr>";
                    		}
                		
            		?>
        		</tbody>
    		</table>
    		
    		<br />
    		<h4>
    			Find the result of a certain event.
    		</h4>
    		<br />

    		<table class="table table-dark">
        		<thead>
            		<tr>
                		<th scope="col">FirstName</th>
                		<th scope="col">LastName</th>
                		<th scope="col">AthleteID</th>
                		<th scope="col">Place</th>
          
            		</tr>
        		</thead>
        		<tbody id="studentTable">
            		<?php
                		// FILL TABLE WITH DATA ON CLICK
                		
                		
                		if(isset($_POST["code"])){
                    		// get all our student data
                    		$code1 = mysqli_real_escape_string($conn, $_POST['code']);
                    		$query = "SELECT DISTINCT Athlete.FirstName, Athlete.LastName, Register.AthleteID,Register.Place FROM Athlete,Register 
                    		WHERE Athlete.AthleteID = Register.AthleteID AND Register.AthleteID IN (SELECT AthleteID FROM Register WHERE EventCode = $code1)" ;
                    		$result = mysqli_query($conn, $query);
                    		// put all our results into a html table
                    		while ($rows = mysqli_fetch_array($result)) {
                        		echo "<tr>";
                        		echo "<td>".$rows["FirstName"]."</td>";
                        		echo "<td>".$rows["LastName"]."</td>";
                        		echo "<td>".$rows["AthleteID"]."</td>";
                        		echo "<td>".$rows["Place"]."</td>";
                        		echo "</tr>";
                    		}
                		}
            		?>
        		</tbody>
    		</table>
    		<form action="" method="post">
    			<input type="text" name="code"/>
    			<input type="submit" value="Input EventCode" />
    		</form>
    		
    		<br />
    		<h4>
    			Find the athlete's name who won a certain place.
    		</h4>
    		<br />
    		
    		<table class="table table-dark">
        		<thead>
            		<tr>
                		<th scope="col">FirstName</th>
                		<th scope="col">LastName</th>
          
            		</tr>
        		</thead>
        		
        		<tbody id="studentTable">
            		<?php
                		// FILL TABLE WITH DATA ON CLICK
                		
                		
                		if(isset($_POST["code1"])){
                    		// get all our student data
                    		$code2 = mysqli_real_escape_string($conn, $_POST['code1']);
                    		$query2 = "SELECT FirstName, LastName FROM Athlete WHERE AthleteID IN (SELECT AthleteID FROM Register WHERE Place = $code2 GROUP BY EventCode)" ;
                    		$result2 = mysqli_query($conn, $query2);
                    		// put all our results into a html table
                    		while ($rows = mysqli_fetch_array($result2)) {
                        		echo "<tr>";
                        		echo "<td>".$rows["FirstName"]."</td>";
                        		echo "<td>".$rows["LastName"]."</td>";
                        		echo "</tr>";
                    		}
                		}
            		?>
        		</tbody>
    		</table>
    		<form action="" method="post">
    			<input type="text" name="code1"/>
    			<input type="submit" value="Input Place" />
    		</form>
    		
    	
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>