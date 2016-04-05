<?php

namespace BossEdu\Model\Base;

use \Exception;
use \PDO;
use BossEdu\Model\PiStatus as ChildPiStatus;
use BossEdu\Model\PiStatusQuery as ChildPiStatusQuery;
use BossEdu\Model\Map\PiStatusTableMap;
use Propel\Runtime\Propel;
use Propel\Runtime\ActiveQuery\Criteria;
use Propel\Runtime\ActiveQuery\ModelCriteria;
use Propel\Runtime\ActiveQuery\ModelJoin;
use Propel\Runtime\Collection\ObjectCollection;
use Propel\Runtime\Connection\ConnectionInterface;
use Propel\Runtime\Exception\PropelException;

/**
 * Base class that represents a query for the 'pi_status' table.
 *
 * 
 *
 * @method     ChildPiStatusQuery orderByPersonId($order = Criteria::ASC) Order by the person_id column
 * @method     ChildPiStatusQuery orderByInstructionId($order = Criteria::ASC) Order by the instruction_id column
 * @method     ChildPiStatusQuery orderByOnline($order = Criteria::ASC) Order by the online column
 * @method     ChildPiStatusQuery orderByEnterAt($order = Criteria::ASC) Order by the enter_at column
 *
 * @method     ChildPiStatusQuery groupByPersonId() Group by the person_id column
 * @method     ChildPiStatusQuery groupByInstructionId() Group by the instruction_id column
 * @method     ChildPiStatusQuery groupByOnline() Group by the online column
 * @method     ChildPiStatusQuery groupByEnterAt() Group by the enter_at column
 *
 * @method     ChildPiStatusQuery leftJoin($relation) Adds a LEFT JOIN clause to the query
 * @method     ChildPiStatusQuery rightJoin($relation) Adds a RIGHT JOIN clause to the query
 * @method     ChildPiStatusQuery innerJoin($relation) Adds a INNER JOIN clause to the query
 *
 * @method     ChildPiStatusQuery leftJoinWith($relation) Adds a LEFT JOIN clause and with to the query
 * @method     ChildPiStatusQuery rightJoinWith($relation) Adds a RIGHT JOIN clause and with to the query
 * @method     ChildPiStatusQuery innerJoinWith($relation) Adds a INNER JOIN clause and with to the query
 *
 * @method     ChildPiStatusQuery leftJoinPerson($relationAlias = null) Adds a LEFT JOIN clause to the query using the Person relation
 * @method     ChildPiStatusQuery rightJoinPerson($relationAlias = null) Adds a RIGHT JOIN clause to the query using the Person relation
 * @method     ChildPiStatusQuery innerJoinPerson($relationAlias = null) Adds a INNER JOIN clause to the query using the Person relation
 *
 * @method     ChildPiStatusQuery joinWithPerson($joinType = Criteria::INNER_JOIN) Adds a join clause and with to the query using the Person relation
 *
 * @method     ChildPiStatusQuery leftJoinWithPerson() Adds a LEFT JOIN clause and with to the query using the Person relation
 * @method     ChildPiStatusQuery rightJoinWithPerson() Adds a RIGHT JOIN clause and with to the query using the Person relation
 * @method     ChildPiStatusQuery innerJoinWithPerson() Adds a INNER JOIN clause and with to the query using the Person relation
 *
 * @method     ChildPiStatusQuery leftJoinInstruction($relationAlias = null) Adds a LEFT JOIN clause to the query using the Instruction relation
 * @method     ChildPiStatusQuery rightJoinInstruction($relationAlias = null) Adds a RIGHT JOIN clause to the query using the Instruction relation
 * @method     ChildPiStatusQuery innerJoinInstruction($relationAlias = null) Adds a INNER JOIN clause to the query using the Instruction relation
 *
 * @method     ChildPiStatusQuery joinWithInstruction($joinType = Criteria::INNER_JOIN) Adds a join clause and with to the query using the Instruction relation
 *
 * @method     ChildPiStatusQuery leftJoinWithInstruction() Adds a LEFT JOIN clause and with to the query using the Instruction relation
 * @method     ChildPiStatusQuery rightJoinWithInstruction() Adds a RIGHT JOIN clause and with to the query using the Instruction relation
 * @method     ChildPiStatusQuery innerJoinWithInstruction() Adds a INNER JOIN clause and with to the query using the Instruction relation
 *
 * @method     \BossEdu\Model\PersonQuery|\BossEdu\Model\InstructionQuery endUse() Finalizes a secondary criteria and merges it with its primary Criteria
 *
 * @method     ChildPiStatus findOne(ConnectionInterface $con = null) Return the first ChildPiStatus matching the query
 * @method     ChildPiStatus findOneOrCreate(ConnectionInterface $con = null) Return the first ChildPiStatus matching the query, or a new ChildPiStatus object populated from the query conditions when no match is found
 *
 * @method     ChildPiStatus findOneByPersonId(int $person_id) Return the first ChildPiStatus filtered by the person_id column
 * @method     ChildPiStatus findOneByInstructionId(int $instruction_id) Return the first ChildPiStatus filtered by the instruction_id column
 * @method     ChildPiStatus findOneByOnline(boolean $online) Return the first ChildPiStatus filtered by the online column
 * @method     ChildPiStatus findOneByEnterAt(string $enter_at) Return the first ChildPiStatus filtered by the enter_at column *

 * @method     ChildPiStatus requirePk($key, ConnectionInterface $con = null) Return the ChildPiStatus by primary key and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 * @method     ChildPiStatus requireOne(ConnectionInterface $con = null) Return the first ChildPiStatus matching the query and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 *
 * @method     ChildPiStatus requireOneByPersonId(int $person_id) Return the first ChildPiStatus filtered by the person_id column and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 * @method     ChildPiStatus requireOneByInstructionId(int $instruction_id) Return the first ChildPiStatus filtered by the instruction_id column and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 * @method     ChildPiStatus requireOneByOnline(boolean $online) Return the first ChildPiStatus filtered by the online column and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 * @method     ChildPiStatus requireOneByEnterAt(string $enter_at) Return the first ChildPiStatus filtered by the enter_at column and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 *
 * @method     ChildPiStatus[]|ObjectCollection find(ConnectionInterface $con = null) Return ChildPiStatus objects based on current ModelCriteria
 * @method     ChildPiStatus[]|ObjectCollection findByPersonId(int $person_id) Return ChildPiStatus objects filtered by the person_id column
 * @method     ChildPiStatus[]|ObjectCollection findByInstructionId(int $instruction_id) Return ChildPiStatus objects filtered by the instruction_id column
 * @method     ChildPiStatus[]|ObjectCollection findByOnline(boolean $online) Return ChildPiStatus objects filtered by the online column
 * @method     ChildPiStatus[]|ObjectCollection findByEnterAt(string $enter_at) Return ChildPiStatus objects filtered by the enter_at column
 * @method     ChildPiStatus[]|\Propel\Runtime\Util\PropelModelPager paginate($page = 1, $maxPerPage = 10, ConnectionInterface $con = null) Issue a SELECT query based on the current ModelCriteria and uses a page and a maximum number of results per page to compute an offset and a limit
 *
 */
abstract class PiStatusQuery extends ModelCriteria
{
    protected $entityNotFoundExceptionClass = '\\Propel\\Runtime\\Exception\\EntityNotFoundException';

    /**
     * Initializes internal state of \BossEdu\Model\Base\PiStatusQuery object.
     *
     * @param     string $dbName The database name
     * @param     string $modelName The phpName of a model, e.g. 'Book'
     * @param     string $modelAlias The alias for the model in this query, e.g. 'b'
     */
    public function __construct($dbName = 'default', $modelName = '\\BossEdu\\Model\\PiStatus', $modelAlias = null)
    {
        parent::__construct($dbName, $modelName, $modelAlias);
    }

    /**
     * Returns a new ChildPiStatusQuery object.
     *
     * @param     string $modelAlias The alias of a model in the query
     * @param     Criteria $criteria Optional Criteria to build the query from
     *
     * @return ChildPiStatusQuery
     */
    public static function create($modelAlias = null, Criteria $criteria = null)
    {
        if ($criteria instanceof ChildPiStatusQuery) {
            return $criteria;
        }
        $query = new ChildPiStatusQuery();
        if (null !== $modelAlias) {
            $query->setModelAlias($modelAlias);
        }
        if ($criteria instanceof Criteria) {
            $query->mergeWith($criteria);
        }

        return $query;
    }

    /**
     * Find object by primary key.
     * Propel uses the instance pool to skip the database if the object exists.
     * Go fast if the query is untouched.
     *
     * <code>
     * $obj = $c->findPk(array(12, 34), $con);
     * </code>
     *
     * @param array[$person_id, $instruction_id] $key Primary key to use for the query
     * @param ConnectionInterface $con an optional connection object
     *
     * @return ChildPiStatus|array|mixed the result, formatted by the current formatter
     */
    public function findPk($key, ConnectionInterface $con = null)
    {
        if ($key === null) {
            return null;
        }
        if ((null !== ($obj = PiStatusTableMap::getInstanceFromPool(serialize([(null === $key[0] || is_scalar($key[0]) || is_callable([$key[0], '__toString']) ? (string) $key[0] : $key[0]), (null === $key[1] || is_scalar($key[1]) || is_callable([$key[1], '__toString']) ? (string) $key[1] : $key[1])])))) && !$this->formatter) {
            // the object is already in the instance pool
            return $obj;
        }
        if ($con === null) {
            $con = Propel::getServiceContainer()->getReadConnection(PiStatusTableMap::DATABASE_NAME);
        }
        $this->basePreSelect($con);
        if ($this->formatter || $this->modelAlias || $this->with || $this->select
         || $this->selectColumns || $this->asColumns || $this->selectModifiers
         || $this->map || $this->having || $this->joins) {
            return $this->findPkComplex($key, $con);
        } else {
            return $this->findPkSimple($key, $con);
        }
    }

    /**
     * Find object by primary key using raw SQL to go fast.
     * Bypass doSelect() and the object formatter by using generated code.
     *
     * @param     mixed $key Primary key to use for the query
     * @param     ConnectionInterface $con A connection object
     *
     * @throws \Propel\Runtime\Exception\PropelException
     *
     * @return ChildPiStatus A model object, or null if the key is not found
     */
    protected function findPkSimple($key, ConnectionInterface $con)
    {
        $sql = 'SELECT person_id, instruction_id, online, enter_at FROM pi_status WHERE person_id = :p0 AND instruction_id = :p1';
        try {
            $stmt = $con->prepare($sql);            
            $stmt->bindValue(':p0', $key[0], PDO::PARAM_INT);            
            $stmt->bindValue(':p1', $key[1], PDO::PARAM_INT);
            $stmt->execute();
        } catch (Exception $e) {
            Propel::log($e->getMessage(), Propel::LOG_ERR);
            throw new PropelException(sprintf('Unable to execute SELECT statement [%s]', $sql), 0, $e);
        }
        $obj = null;
        if ($row = $stmt->fetch(\PDO::FETCH_NUM)) {
            /** @var ChildPiStatus $obj */
            $obj = new ChildPiStatus();
            $obj->hydrate($row);
            PiStatusTableMap::addInstanceToPool($obj, serialize([(null === $key[0] || is_scalar($key[0]) || is_callable([$key[0], '__toString']) ? (string) $key[0] : $key[0]), (null === $key[1] || is_scalar($key[1]) || is_callable([$key[1], '__toString']) ? (string) $key[1] : $key[1])]));
        }
        $stmt->closeCursor();

        return $obj;
    }

    /**
     * Find object by primary key.
     *
     * @param     mixed $key Primary key to use for the query
     * @param     ConnectionInterface $con A connection object
     *
     * @return ChildPiStatus|array|mixed the result, formatted by the current formatter
     */
    protected function findPkComplex($key, ConnectionInterface $con)
    {
        // As the query uses a PK condition, no limit(1) is necessary.
        $criteria = $this->isKeepQuery() ? clone $this : $this;
        $dataFetcher = $criteria
            ->filterByPrimaryKey($key)
            ->doSelect($con);

        return $criteria->getFormatter()->init($criteria)->formatOne($dataFetcher);
    }

    /**
     * Find objects by primary key
     * <code>
     * $objs = $c->findPks(array(array(12, 56), array(832, 123), array(123, 456)), $con);
     * </code>
     * @param     array $keys Primary keys to use for the query
     * @param     ConnectionInterface $con an optional connection object
     *
     * @return ObjectCollection|array|mixed the list of results, formatted by the current formatter
     */
    public function findPks($keys, ConnectionInterface $con = null)
    {
        if (null === $con) {
            $con = Propel::getServiceContainer()->getReadConnection($this->getDbName());
        }
        $this->basePreSelect($con);
        $criteria = $this->isKeepQuery() ? clone $this : $this;
        $dataFetcher = $criteria
            ->filterByPrimaryKeys($keys)
            ->doSelect($con);

        return $criteria->getFormatter()->init($criteria)->format($dataFetcher);
    }

    /**
     * Filter the query by primary key
     *
     * @param     mixed $key Primary key to use for the query
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByPrimaryKey($key)
    {
        $this->addUsingAlias(PiStatusTableMap::COL_PERSON_ID, $key[0], Criteria::EQUAL);
        $this->addUsingAlias(PiStatusTableMap::COL_INSTRUCTION_ID, $key[1], Criteria::EQUAL);

        return $this;
    }

    /**
     * Filter the query by a list of primary keys
     *
     * @param     array $keys The list of primary key to use for the query
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByPrimaryKeys($keys)
    {
        if (empty($keys)) {
            return $this->add(null, '1<>1', Criteria::CUSTOM);
        }
        foreach ($keys as $key) {
            $cton0 = $this->getNewCriterion(PiStatusTableMap::COL_PERSON_ID, $key[0], Criteria::EQUAL);
            $cton1 = $this->getNewCriterion(PiStatusTableMap::COL_INSTRUCTION_ID, $key[1], Criteria::EQUAL);
            $cton0->addAnd($cton1);
            $this->addOr($cton0);
        }

        return $this;
    }

    /**
     * Filter the query on the person_id column
     *
     * Example usage:
     * <code>
     * $query->filterByPersonId(1234); // WHERE person_id = 1234
     * $query->filterByPersonId(array(12, 34)); // WHERE person_id IN (12, 34)
     * $query->filterByPersonId(array('min' => 12)); // WHERE person_id > 12
     * </code>
     *
     * @see       filterByPerson()
     *
     * @param     mixed $personId The value to use as filter.
     *              Use scalar values for equality.
     *              Use array values for in_array() equivalent.
     *              Use associative array('min' => $minValue, 'max' => $maxValue) for intervals.
     * @param     string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByPersonId($personId = null, $comparison = null)
    {
        if (is_array($personId)) {
            $useMinMax = false;
            if (isset($personId['min'])) {
                $this->addUsingAlias(PiStatusTableMap::COL_PERSON_ID, $personId['min'], Criteria::GREATER_EQUAL);
                $useMinMax = true;
            }
            if (isset($personId['max'])) {
                $this->addUsingAlias(PiStatusTableMap::COL_PERSON_ID, $personId['max'], Criteria::LESS_EQUAL);
                $useMinMax = true;
            }
            if ($useMinMax) {
                return $this;
            }
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }
        }

        return $this->addUsingAlias(PiStatusTableMap::COL_PERSON_ID, $personId, $comparison);
    }

    /**
     * Filter the query on the instruction_id column
     *
     * Example usage:
     * <code>
     * $query->filterByInstructionId(1234); // WHERE instruction_id = 1234
     * $query->filterByInstructionId(array(12, 34)); // WHERE instruction_id IN (12, 34)
     * $query->filterByInstructionId(array('min' => 12)); // WHERE instruction_id > 12
     * </code>
     *
     * @see       filterByInstruction()
     *
     * @param     mixed $instructionId The value to use as filter.
     *              Use scalar values for equality.
     *              Use array values for in_array() equivalent.
     *              Use associative array('min' => $minValue, 'max' => $maxValue) for intervals.
     * @param     string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByInstructionId($instructionId = null, $comparison = null)
    {
        if (is_array($instructionId)) {
            $useMinMax = false;
            if (isset($instructionId['min'])) {
                $this->addUsingAlias(PiStatusTableMap::COL_INSTRUCTION_ID, $instructionId['min'], Criteria::GREATER_EQUAL);
                $useMinMax = true;
            }
            if (isset($instructionId['max'])) {
                $this->addUsingAlias(PiStatusTableMap::COL_INSTRUCTION_ID, $instructionId['max'], Criteria::LESS_EQUAL);
                $useMinMax = true;
            }
            if ($useMinMax) {
                return $this;
            }
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }
        }

        return $this->addUsingAlias(PiStatusTableMap::COL_INSTRUCTION_ID, $instructionId, $comparison);
    }

    /**
     * Filter the query on the online column
     *
     * Example usage:
     * <code>
     * $query->filterByOnline(true); // WHERE online = true
     * $query->filterByOnline('yes'); // WHERE online = true
     * </code>
     *
     * @param     boolean|string $online The value to use as filter.
     *              Non-boolean arguments are converted using the following rules:
     *                * 1, '1', 'true',  'on',  and 'yes' are converted to boolean true
     *                * 0, '0', 'false', 'off', and 'no'  are converted to boolean false
     *              Check on string values is case insensitive (so 'FaLsE' is seen as 'false').
     * @param     string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByOnline($online = null, $comparison = null)
    {
        if (is_string($online)) {
            $online = in_array(strtolower($online), array('false', 'off', '-', 'no', 'n', '0', '')) ? false : true;
        }

        return $this->addUsingAlias(PiStatusTableMap::COL_ONLINE, $online, $comparison);
    }

    /**
     * Filter the query on the enter_at column
     *
     * Example usage:
     * <code>
     * $query->filterByEnterAt('2011-03-14'); // WHERE enter_at = '2011-03-14'
     * $query->filterByEnterAt('now'); // WHERE enter_at = '2011-03-14'
     * $query->filterByEnterAt(array('max' => 'yesterday')); // WHERE enter_at > '2011-03-13'
     * </code>
     *
     * @param     mixed $enterAt The value to use as filter.
     *              Values can be integers (unix timestamps), DateTime objects, or strings.
     *              Empty strings are treated as NULL.
     *              Use scalar values for equality.
     *              Use array values for in_array() equivalent.
     *              Use associative array('min' => $minValue, 'max' => $maxValue) for intervals.
     * @param     string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByEnterAt($enterAt = null, $comparison = null)
    {
        if (is_array($enterAt)) {
            $useMinMax = false;
            if (isset($enterAt['min'])) {
                $this->addUsingAlias(PiStatusTableMap::COL_ENTER_AT, $enterAt['min'], Criteria::GREATER_EQUAL);
                $useMinMax = true;
            }
            if (isset($enterAt['max'])) {
                $this->addUsingAlias(PiStatusTableMap::COL_ENTER_AT, $enterAt['max'], Criteria::LESS_EQUAL);
                $useMinMax = true;
            }
            if ($useMinMax) {
                return $this;
            }
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }
        }

        return $this->addUsingAlias(PiStatusTableMap::COL_ENTER_AT, $enterAt, $comparison);
    }

    /**
     * Filter the query by a related \BossEdu\Model\Person object
     *
     * @param \BossEdu\Model\Person|ObjectCollection $person The related object(s) to use as filter
     * @param string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @throws \Propel\Runtime\Exception\PropelException
     *
     * @return ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByPerson($person, $comparison = null)
    {
        if ($person instanceof \BossEdu\Model\Person) {
            return $this
                ->addUsingAlias(PiStatusTableMap::COL_PERSON_ID, $person->getId(), $comparison);
        } elseif ($person instanceof ObjectCollection) {
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }

            return $this
                ->addUsingAlias(PiStatusTableMap::COL_PERSON_ID, $person->toKeyValue('PrimaryKey', 'Id'), $comparison);
        } else {
            throw new PropelException('filterByPerson() only accepts arguments of type \BossEdu\Model\Person or Collection');
        }
    }

    /**
     * Adds a JOIN clause to the query using the Person relation
     *
     * @param     string $relationAlias optional alias for the relation
     * @param     string $joinType Accepted values are null, 'left join', 'right join', 'inner join'
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function joinPerson($relationAlias = null, $joinType = Criteria::INNER_JOIN)
    {
        $tableMap = $this->getTableMap();
        $relationMap = $tableMap->getRelation('Person');

        // create a ModelJoin object for this join
        $join = new ModelJoin();
        $join->setJoinType($joinType);
        $join->setRelationMap($relationMap, $this->useAliasInSQL ? $this->getModelAlias() : null, $relationAlias);
        if ($previousJoin = $this->getPreviousJoin()) {
            $join->setPreviousJoin($previousJoin);
        }

        // add the ModelJoin to the current object
        if ($relationAlias) {
            $this->addAlias($relationAlias, $relationMap->getRightTable()->getName());
            $this->addJoinObject($join, $relationAlias);
        } else {
            $this->addJoinObject($join, 'Person');
        }

        return $this;
    }

    /**
     * Use the Person relation Person object
     *
     * @see useQuery()
     *
     * @param     string $relationAlias optional alias for the relation,
     *                                   to be used as main alias in the secondary query
     * @param     string $joinType Accepted values are null, 'left join', 'right join', 'inner join'
     *
     * @return \BossEdu\Model\PersonQuery A secondary query class using the current class as primary query
     */
    public function usePersonQuery($relationAlias = null, $joinType = Criteria::INNER_JOIN)
    {
        return $this
            ->joinPerson($relationAlias, $joinType)
            ->useQuery($relationAlias ? $relationAlias : 'Person', '\BossEdu\Model\PersonQuery');
    }

    /**
     * Filter the query by a related \BossEdu\Model\Instruction object
     *
     * @param \BossEdu\Model\Instruction|ObjectCollection $instruction The related object(s) to use as filter
     * @param string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @throws \Propel\Runtime\Exception\PropelException
     *
     * @return ChildPiStatusQuery The current query, for fluid interface
     */
    public function filterByInstruction($instruction, $comparison = null)
    {
        if ($instruction instanceof \BossEdu\Model\Instruction) {
            return $this
                ->addUsingAlias(PiStatusTableMap::COL_INSTRUCTION_ID, $instruction->getId(), $comparison);
        } elseif ($instruction instanceof ObjectCollection) {
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }

            return $this
                ->addUsingAlias(PiStatusTableMap::COL_INSTRUCTION_ID, $instruction->toKeyValue('PrimaryKey', 'Id'), $comparison);
        } else {
            throw new PropelException('filterByInstruction() only accepts arguments of type \BossEdu\Model\Instruction or Collection');
        }
    }

    /**
     * Adds a JOIN clause to the query using the Instruction relation
     *
     * @param     string $relationAlias optional alias for the relation
     * @param     string $joinType Accepted values are null, 'left join', 'right join', 'inner join'
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function joinInstruction($relationAlias = null, $joinType = Criteria::INNER_JOIN)
    {
        $tableMap = $this->getTableMap();
        $relationMap = $tableMap->getRelation('Instruction');

        // create a ModelJoin object for this join
        $join = new ModelJoin();
        $join->setJoinType($joinType);
        $join->setRelationMap($relationMap, $this->useAliasInSQL ? $this->getModelAlias() : null, $relationAlias);
        if ($previousJoin = $this->getPreviousJoin()) {
            $join->setPreviousJoin($previousJoin);
        }

        // add the ModelJoin to the current object
        if ($relationAlias) {
            $this->addAlias($relationAlias, $relationMap->getRightTable()->getName());
            $this->addJoinObject($join, $relationAlias);
        } else {
            $this->addJoinObject($join, 'Instruction');
        }

        return $this;
    }

    /**
     * Use the Instruction relation Instruction object
     *
     * @see useQuery()
     *
     * @param     string $relationAlias optional alias for the relation,
     *                                   to be used as main alias in the secondary query
     * @param     string $joinType Accepted values are null, 'left join', 'right join', 'inner join'
     *
     * @return \BossEdu\Model\InstructionQuery A secondary query class using the current class as primary query
     */
    public function useInstructionQuery($relationAlias = null, $joinType = Criteria::INNER_JOIN)
    {
        return $this
            ->joinInstruction($relationAlias, $joinType)
            ->useQuery($relationAlias ? $relationAlias : 'Instruction', '\BossEdu\Model\InstructionQuery');
    }

    /**
     * Exclude object from result
     *
     * @param   ChildPiStatus $piStatus Object to remove from the list of results
     *
     * @return $this|ChildPiStatusQuery The current query, for fluid interface
     */
    public function prune($piStatus = null)
    {
        if ($piStatus) {
            $this->addCond('pruneCond0', $this->getAliasedColName(PiStatusTableMap::COL_PERSON_ID), $piStatus->getPersonId(), Criteria::NOT_EQUAL);
            $this->addCond('pruneCond1', $this->getAliasedColName(PiStatusTableMap::COL_INSTRUCTION_ID), $piStatus->getInstructionId(), Criteria::NOT_EQUAL);
            $this->combine(array('pruneCond0', 'pruneCond1'), Criteria::LOGICAL_OR);
        }

        return $this;
    }

    /**
     * Deletes all rows from the pi_status table.
     *
     * @param ConnectionInterface $con the connection to use
     * @return int The number of affected rows (if supported by underlying database driver).
     */
    public function doDeleteAll(ConnectionInterface $con = null)
    {
        if (null === $con) {
            $con = Propel::getServiceContainer()->getWriteConnection(PiStatusTableMap::DATABASE_NAME);
        }

        // use transaction because $criteria could contain info
        // for more than one table or we could emulating ON DELETE CASCADE, etc.
        return $con->transaction(function () use ($con) {
            $affectedRows = 0; // initialize var to track total num of affected rows
            $affectedRows += parent::doDeleteAll($con);
            // Because this db requires some delete cascade/set null emulation, we have to
            // clear the cached instance *after* the emulation has happened (since
            // instances get re-added by the select statement contained therein).
            PiStatusTableMap::clearInstancePool();
            PiStatusTableMap::clearRelatedInstancePool();

            return $affectedRows;
        });
    }

    /**
     * Performs a DELETE on the database based on the current ModelCriteria
     *
     * @param ConnectionInterface $con the connection to use
     * @return int             The number of affected rows (if supported by underlying database driver).  This includes CASCADE-related rows
     *                         if supported by native driver or if emulated using Propel.
     * @throws PropelException Any exceptions caught during processing will be
     *                         rethrown wrapped into a PropelException.
     */
    public function delete(ConnectionInterface $con = null)
    {
        if (null === $con) {
            $con = Propel::getServiceContainer()->getWriteConnection(PiStatusTableMap::DATABASE_NAME);
        }

        $criteria = $this;

        // Set the correct dbName
        $criteria->setDbName(PiStatusTableMap::DATABASE_NAME);

        // use transaction because $criteria could contain info
        // for more than one table or we could emulating ON DELETE CASCADE, etc.
        return $con->transaction(function () use ($con, $criteria) {
            $affectedRows = 0; // initialize var to track total num of affected rows
            
            PiStatusTableMap::removeInstanceFromPool($criteria);
        
            $affectedRows += ModelCriteria::delete($con);
            PiStatusTableMap::clearRelatedInstancePool();

            return $affectedRows;
        });
    }

} // PiStatusQuery
