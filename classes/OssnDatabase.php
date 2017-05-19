<?php

/**
 * Open Source Social Network
 *
 * @package   (softlab24.com).ossn
 * @author    OSSN Core Team <info@softlab24.com>
 * @copyright 2014-2017 SOFTLAB24 LIMITED
 * @license   Open Source Social Network License (OSSN LICENSE)  http://www.opensource-socialnetwork.org/licence
 * @link      https://www.opensource-socialnetwork.org/
 */
class OssnDatabase extends OssnBase {
		/**
		 * Connect to mysql database
		 *
		 * @return boolean
		 */
		public function Connect() {
				$settings = ossn_database_settings();
/*				$connect  = new mysqli($settings->host, $settings->user, $settings->password, $settings->database, $settings->port);*/
/*
        $xhost = "host=".$settings->host;
        $xport = "port=".$settings->port;
        $xdbname = "dbname=".$settings->database;
        $xuser = "user=".$settings->user;
        $xpassword = "password=".$settings->password;

        $connect = pg_connect("$xhost $xport $xdbname $xuser $xpassword");
*/

        $connect = pg_connect("host=$settings->host port=$settings->port dbname=$settings->database user=$settings->user password=$settings->password");

        
        
/*        if(!$connect->connect_errno) {
						return $connect;
				} else {
						return false;
				}
        
        
        		$stat = pg_connection_status($connect);
                                if ($stat === PGSQL_CONNECTION_OK){
                                    		return $connect;
				} else {
						return false;
				}
*/
		    if ($connect)
        { return $connect; }
        else {
          return false;
        }


        
		}
		/**
		 * Prepare a query to insert data in database
		 *
		 * @param array array();
		 * 			'names' Names of columns
		 *          'values' Values that need to be inserted
		 *          'into' Table name
		 *
		 * @return boolean
		 */
		public function insert($params) {
				if(is_array($params)) {
						if(count($params['names']) == count($params['values'])) {
                /*		$colums = "`" . implode("`, `", $params['names']) . '`';*/
                /* added PostgreSQL fork */
								$colums = '"' . implode('", "', $params['names']) . '"';
                $values = "'" . implode("', '", $params['values']) . "'";
								$query  = "INSERT INTO {$params['into']} ($colums) VALUES ($values);";
								$this->statement($query);
								if($this->execute()) {
										return true;
								}
						}
				}
				return false;
		}
		
		/**
		 * Prepare a mysqli query
		 *
		 * @return boolean
		 */
		public function statement($query) {
				if(!empty($query)) {
						$this->query = $query;
						return true;
				}
				return false;
		}
		
		/**
		 * Execute a mysqli query and store result in memory
		 *
		 * @return boolean
		 */
		public function execute() {
				$this->database = $this->Connect();
				if(isset($this->query) && !empty($this->query)) {
						/*$this->database->set_charset("utf8");
            	$this->exe = $this->database->query($this->query);            
            */            
						$this->exe = pg_query($this->database,$this->query);
 
    /*    error_log($this->query);*/
if (preg_match('/ossn_users/',$this->query))
{
error_log($this->query);
}
						$exception = ossn_call_hook('database', 'execution:message', false, true);
						if(!$this->exe && $exception) {
            
            echo $this->query;
            
								throw new OssnDatabaseException("{$this->database->error} \n {$this->query} ");
						}
            /*
            if(isset($this->database->insert_id)) {
								$this->last_id = $this->database->insert_id;
						}
            */            
                        
						if (preg_match('/INSERT/',$this->query))
            {
                $insert_query = pg_query($this->database,"SELECT lastval();");
                $insert_row = pg_fetch_row($insert_query);
                $this->last_id = (int)$insert_row[0];
								
						}
            
						unset($this->query);
						pg_close($this->database);
						return true;
				}
				return false;
		}
		
		/**
		 * Prepare a query to update data in database
		 *
		 * @param array array();
		 *          'names' Names of columns
		 *          'values' Values that need to be updated
		 *          'table'	Table name
		 *          'wheres' Specify a selection criteria to update required records
		 *
		 * @return boolean
		 */
		public function update($params = array()) {
				if(is_array($params)) {
						if(count($params['names']) == count($params['values']) && !empty($params['table'])) {
								$valuec = count($params['names']);
								$i      = 1;
								foreach($params['names'] as $key => $val) {
										$data[$val] = $params['values'][$key];
								}
								foreach($data as $keys => $vals) {
										if($i == $valuec) {
                    /* 	$valyes[] = "`{$keys}` = '{$vals}'";*/
												$valyes[] =  "{$keys} = '{$vals}'";
										} else {
                    /* 	$valyes[] = "`{$keys}` = '{$vals}',";*/
												$valyes[] = "{$keys} = '{$vals}',";
										}
										$i++;
								}
								$q                = implode('', $valyes);
								$params['wheres'] = implode(' ', $params['wheres']);
								$query            = "UPDATE {$params['table']} SET {$q} WHERE {$params['wheres']}";
								$this->statement($query);
								if($this->execute()) {
										return true;
								}
								
						}
				}
				return false;
		}
		
		/**
		 * Prepare a query to select data from database
		 *
		 * @param array array();
		 *           'from' Names of table
		 *           'params' Names of columns which you want to select
		 *           'wheres' Specify a selection criteria to get required records
		 *
		 * @return boolean
		 */
		public function select($params, $multi = '') {
				if(is_array($params)) {
						if(!isset($params['params'])) {
								$parameters = '*';
						} else {
								$parameters = implode(', ', $params['params']);
						}
						$order_by = '';
						if(!empty($params['order_by'])) {
								$order_by = "ORDER by {$params['order_by']}";
						}
						$group_by = '';
						if(!empty($params['group_by'])) {
								$group_by = "GROUP by {$params['group_by']}";
						}						
						$where = '';
						if(isset($params['wheres']) && is_array($params['wheres'])) {
								$where = implode(' ', $params['wheres']);
						}
						$wheres = '';
						if(!empty($params['wheres'])) {
								$wheres = "WHERE({$where})";
						}
						$limit = '';
						if(!empty($params['limit'])) {
								$limit = "LIMIT {$params['limit']}";
						}
						$joins = '';
						if(!empty($params['joins']) && !is_array($params['joins'])) {
								$joins = $params['joins'];
						} elseif(!empty($params['joins']) && is_array($params['joins'])) {
								$joins = implode(' ', $params['joins']);
						}
            /*$query = "SELECT {$parameters} FROM {$params['from']} {$joins} {$wheres} {$order_by} {$group_by} {$limit};";*/
            
						$query = "SELECT {$parameters} FROM {$params['from']} {$joins} {$wheres} {$group_by} {$order_by} {$limit};";
						
						$this->statement($query);
						if($this->execute()) {
								return $this->fetch($multi);
						}
				}
				return false;
		}
		
		/**
		 * Fetch the data from memory that is stored during execution;
		 *
		 * @param boolean $data Ture if you want to fetch all data , or false if only one row
		 *
		 * @return boolean
		 */
		public function fetch($data = false) {
				if(isset($this->exe)) {
						if($data !== true) {
								if($fetch = $this->exe) {
                   /*return arrayObject($fetch->fetch_assoc());*/
										return arrayObject(pg_fetch_assoc($fetch));
								}
						}
						if($data === true) {
								if($fetch = $this->exe) {
                    /* 	while($all = $fetch->fetch_assoc()) {*/
										while($all = pg_fetch_assoc($fetch)) {
												$alldata[] = arrayObject($all);
										}
								}
								if(isset($alldata) && !empty($alldata)) {
										return arrayObject($alldata);
								}
						}
				}
				return false;
		}
		
		/**
		 * Prepare a query to delete data from database
		 *
		 * @param array array();
		 *           'from' Names of table
		 *           'wheres' Specify a selection criteria to get required records
		 *
		 * @return boolean
		 */
		public function delete($params) {
				if(is_array($params)) {
						$where = implode(' ', $params['wheres']);
						if(!empty($params['wheres'])) {
								$wheres = "WHERE({$where})";
						}
						//don't let any component or query to empty entire table
						if(empty($params['wheres'])) {
								return false;
						}
						$query = "DELETE FROM `{$params['from']}` {$wheres};";
						$this->statement($query);
						if($this->execute()) {
								return true;
						}
				}
				return false;
		}
		
		/**
		 * Get a guid of newly create entry
		 *
		 * @return integer
		 */
		public function getLastEntry() {
				if(!empty($this->last_id)) {
						return $this->last_id;
				}
		}
		/**
		 * Create a wheres clause for database
		 *
		 * @param array $array A valid array containg wheres clauses;
		 * @param string $operator AND, OR, LIKE
		 *
		 * @return string
		 */
		public function constructWheres(array $array, $operator = "AND") {
				if(!empty($array) && !empty($operator)) {
						$result = implode(" {$operator} ", $array);
						return $result;
				}
				return false;
		}
		/**
		 * Generate limit from options
		 * 
		 * @param integer $data_limit How much data should be fetched?
		 * @param integer $page_limit Limit of data on one page
		 * @param integer $offset Offset value
		 *
		 * @return string|false
		 */
		public function generateLimit($data_limit = false, $page_limit = false, $offset = false) {
				$limit = $data_limit;
				//get only required result, don't bust your server memory
				if(isset($offset) && $offset !== false && $page_limit !== false) {
						$limitfrom = ($offset - 1) * ($page_limit);
						$limitto   = $page_limit;
						
            /*$data_limit = "{$limitfrom}, {$limitto}";*/
						$data_limit = "{$limitto} OFFSET {$limitfrom}";
						if($offset > 1) {
								if($limit > $limitfrom) {
										$limitto = $limit - $limitfrom;
										if($limitto <= $page_limit) {
												$data_limit = "{$limitfrom}, {$limitto}";
										}
								}
						}
						if(!empty($limit) && $limit < $page_limit) {
								$data_limit = $limit;
						}
						return $data_limit;
				}
				return false;
		}
		
} //class
