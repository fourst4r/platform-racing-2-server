<?php

/**
 * Upsert level content into level_contents table.
 *
 * @param PDO $pdo
 * @param int $level_id
 * @param string $content
 * @return bool
 * @throws Exception on failure
 */
function level_contents_upsert($pdo, $level_id, $content)
{
    $stmt = $pdo->prepare('
        REPLACE INTO level_contents (level_id, content)
        VALUES (:level_id, :content)
    ');
    $stmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
    $stmt->bindValue(':content', $content, PDO::PARAM_STR);
    $result = $stmt->execute();

    if ($result === false) {
        throw new Exception('Could not save level content to the database.');
    }

    return $result;
}
