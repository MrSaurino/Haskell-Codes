import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Data.Maybe (fromMaybe)
import Text.Read (readMaybe)
import Control.Monad (when)
import System.Exit (exitSuccess)
import Data.Time (getCurrentTime, utctDay, formatTime, defaultTimeLocale)
import Data.List (sortOn, sortBy)
import Data.Ord (comparing)

-- Task structure definition
data Task = Task { title :: String, description :: String, category :: String, deadline :: Maybe String, priority :: Int } deriving (Show, Read)

-- Function to read a task from a line
readTask :: T.Text -> Task
readTask line = 
    let parts = T.splitOn (T.pack ", ") line
        title = T.unpack (parts !! 0)
        description = T.unpack (parts !! 1)
        category = T.unpack (parts !! 2)
        deadline = if T.null (parts !! 3) then Nothing else Just (T.unpack (parts !! 3))
        priority = fromMaybe 0 (readMaybe (T.unpack (parts !! 4)) :: Maybe Int)
    in Task title description category deadline priority

-- Function to read tasks from a file
readTasks :: FilePath -> IO [Task]
readTasks filePath = do
    contents <- TIO.readFile filePath
    return (map readTask (T.lines contents))

-- Function to write tasks to a file
writeTasks :: FilePath -> [Task] -> IO ()
writeTasks filePath tasks = do
    let tasksStr = T.unlines (map (T.pack . showTask) tasks)
    TIO.writeFile filePath tasksStr

-- Function to add a task
addTask :: FilePath -> Task -> IO ()
addTask filePath task = do
    tasks <- readTasks filePath
    writeTasks filePath (task : tasks)

-- Function to delete a task
deleteTask :: FilePath -> String -> IO ()
deleteTask filePath taskTitle = do
    tasks <- readTasks filePath
    let newTasks = filter (\task -> title task /= taskTitle) tasks
    writeTasks filePath newTasks

-- Function to edit a task
editTask :: FilePath -> String -> Task -> IO ()
editTask filePath taskTitle newTask = do
    tasks <- readTasks filePath
    let updatedTasks = map (\task -> if title task == taskTitle then mergeTasks task newTask else task) tasks
    writeTasks filePath updatedTasks

-- Function to merge two tasks
mergeTasks :: Task -> Task -> Task
mergeTasks old new = Task
    { title = title old
    , description = if null (description new) then description old else description new
    , category = if null (category new) then category old else category new
    , deadline = if null (fromMaybe "" (deadline new)) then deadline old else deadline new
    , priority = if priority new == 0 then priority old else priority new
    }

-- Function to list tasks
listTasks :: FilePath -> IO ()
listTasks filePath = do
    putStrLn "┌─────────────────────────────────────────────┐"
    putStrLn "│ Select the field to sort by:                │"
    putStrLn "├─────────────────────────────────────────────┤"
    putStrLn "│ 1. Title                                    │"
    putStrLn "│ 2. Category                                 │"
    putStrLn "│ 3. Deadline                                 │"
    putStrLn "│ 4. Priority                                 │"
    putStrLn "└─────────────────────────────────────────────┘"
    choice <- getLine
    tasks <- readTasks filePath
    sortedTasks <- case choice of
        "1" -> return $ sortOn title tasks
        "2" -> return $ sortOn category tasks
        "3" -> return $ sortOn (fromMaybe "" . deadline) tasks
        "4" -> do
            putStrLn "┌────────────────────────────────────┐"
            putStrLn "│ Select priority order:             │"
            putStrLn "├────────────────────────────────────┤"
            putStrLn "│ 1. Ascending                       │"
            putStrLn "│ 2. Descending                      │"
            putStrLn "└────────────────────────────────────┘"
            orderChoice <- getLine
            return $ case orderChoice of
                "1" -> sortOn priority tasks
                "2" -> sortBy (flip $ comparing priority) tasks
                _   -> tasks
        _   -> return tasks
    TIO.putStrLn (T.pack "Title, Description, Category, Deadline, Priority")
    mapM_ (TIO.putStrLn . T.pack . showTask) sortedTasks

-- Function to show a task
showTask :: Task -> String
showTask task = title task ++ ", " ++ description task ++ ", " ++ category task ++ ", " ++ maybe "" id (deadline task) ++ ", " ++ show (priority task)

-- Main function
main :: IO ()
main = do
    putStrLn "┌────────────────────────────────────┐"
    putStrLn "│      Welcome to Achilles Organize  │"
    putStrLn "├────────────────────────────────────┤"
    putStrLn "│ 1. Add task                        │"
    putStrLn "│ 2. Delete task                     │"
    putStrLn "│ 3. Edit task                       │"
    putStrLn "│ 4. List tasks                      │"
    putStrLn "│ 5. Exit                            │"
    putStrLn "└────────────────────────────────────┘"
    choice <- getLine
    case choice of
        "1" -> do
            putStrLn "Enter task title:"
            title <- getLine
            putStrLn "Enter task description:"
            description <- getLine
            putStrLn "Enter its category:"
            category <- getLine
            putStrLn "Enter the deadline (optional, press Enter to set current date):"
            deadline <- getLine
            putStrLn "Enter the priority:"
            priorityInput <- getLine
            let maybePriority = readMaybe priorityInput :: Maybe Int
            case maybePriority of
                Just priority -> do
                    currentTime <- getCurrentTime
                    let formattedDeadline = if null deadline then Just (formatTime defaultTimeLocale "%F" (utctDay currentTime)) else if deadline == " " then Just (formatTime defaultTimeLocale "%F" (utctDay currentTime)) else Just deadline
                    let task = Task title description category formattedDeadline priority
                    addTask "tasks.txt" task
                    putStrLn "Task added."
                    main
                Nothing -> do
                    putStrLn "Invalid priority, try again."
                    main
        "2" -> do
            putStrLn "Enter the title of the task to delete:"
            title <- getLine
            deleteTask "tasks.txt" title
            putStrLn "Task deleted."
            main
        "3" -> do
            putStrLn "Enter the title of the task to edit:"
            oldTitle <- getLine
            putStrLn "Enter the new task description (leave empty to keep previous):"
            newDescription <- getLine
            putStrLn "Enter the new task category (leave empty to keep previous):"
            newCategory <- getLine
            putStrLn "Enter the new task deadline (optional, leave empty to keep previous):"
            newDeadline <- getLine
            putStrLn "Enter the new task priority (leave empty to keep previous):"
            newPriorityInput <- getLine
            let maybeNewPriority = if null newPriorityInput then Just 0 else readMaybe newPriorityInput :: Maybe Int
            case maybeNewPriority of
                Just newPriority -> do
                    let newTask = Task oldTitle newDescription newCategory (if null newDeadline then Nothing else Just newDeadline) newPriority
                    editTask "tasks.txt" oldTitle newTask
                    putStrLn "Task edited."
                    main
                Nothing -> do
                    putStrLn "Invalid priority, try again."
                    main
        "4" -> do
            listTasks "tasks.txt"
            main
        "5" -> do
            putStrLn "Exiting program."
            exitSuccess
        _ -> do
            putStrLn "Invalid option. Choose another option."
            main